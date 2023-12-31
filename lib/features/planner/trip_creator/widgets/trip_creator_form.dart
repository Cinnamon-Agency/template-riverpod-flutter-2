import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_creator/controller/trip_creation_controller.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/primary_button.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/cotraveler.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_location_picker/map_location_picker.dart' as lp;
import 'package:uuid/uuid.dart';

class TripCreatorForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final _nameNode = FocusNode();
  final _descriptionNode = FocusNode();
  final uuid = const Uuid();

  FormBuilderState? get _currentFormState => _formKey.currentState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(tripCreationStateProvider.notifier);
    var state = ref.watch(tripCreationStateProvider);
    final userData = ref.watch(profileDataProvider);
    final travelers = ref.watch(travelersProvider);

    return FormBuilder(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// --- NAME
            const SizedBox(
              height: 10,
            ),

            FormBuilderTextField(
              name: 'name',
              focusNode: _nameNode,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) =>
                  _currentFormState?.fields['name']?.validate(),
              validator: (value) =>
                  /*!_nameNode.hasPrimaryFocus && */ (value?.isEmpty ?? true)
                      ? 'This field is required.'
                      : null,
            ),

            const SizedBox(
              height: 20,
            ),

            /// ----------- DESCRIPTION
            FormBuilderTextField(
              name: 'description',
              focusNode: _descriptionNode,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
              ),
              onChanged: (value) =>
                  _currentFormState?.fields['description']?.validate(),
              validator: (value) =>
                  /*!_descriptionNode.hasPrimaryFocus && */ (value?.isEmpty ??
                          true)
                      ? 'This field is required.'
                      : null,
            ),

            const SizedBox(height: 20),

            Text(
              'Co-travelers',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),

            /// ----------- CO TRAVELER(S)
            const SizedBox(
              height: 10,
            ),

            /// ------ Form builder field
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: state.requireValue.coTravelers.length,
              itemBuilder: (context, index) =>

                  /// ------ Form builder field
                  Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Autocomplete<String>(
                  key: ValueKey(
                      'coTraveler-${state.requireValue.coTravelers.keys.toList()[index]}'),
                  optionsBuilder: (TextEditingValue textEditingValue) =>
                      textEditingValue.text.isNotEmpty
                          ? travelers.requireValue.map((e) => e.username).where(
                              (String option) =>
                                  option != userData.requireValue.username &&
                                  option.contains(
                                      textEditingValue.text.toLowerCase()))
                          : [],
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    if (textEditingController.text !=
                        state.requireValue.coTravelers.values
                            .toList()[index]
                            .name) {
                      textEditingController.text = state
                          .requireValue.coTravelers.values
                          .toList()[index]
                          .name;
                      textEditingController.selection = TextSelection.collapsed(
                          offset: textEditingController.text.length);
                    }
                    return FormBuilderTextField(
                      key: ValueKey(
                          'coTravelerTextField-${state.requireValue.coTravelers.keys.toList()[index]}'),
                      name:
                          'coTravelerTextField-${state.requireValue.coTravelers.keys.toList()[index]}',
                      controller: textEditingController,
                      focusNode: focusNode,
                      onChanged: (value) {
                        controller.updateCoTravelerName(
                            state.requireValue.coTravelers.keys.toList()[index],
                            travelers.requireValue
                                    .firstWhereOrNull(
                                        (t) => t.username == value)
                                    ?.id ??
                                '',
                            value ?? '');
                        _currentFormState?.fields[
                                'coTravelerTextField-${state.requireValue.coTravelers.keys.toList()[index]}']
                            ?.validate();
                      },
                      decoration: InputDecoration(
                        labelText: 'Co-traveler',
                        suffixIcon: IconButton(
                          onPressed: () {
                            /// Remove form fields
                            _currentFormState?.removeInternalFieldValue(
                                'coTravelerTextField-${state.requireValue.coTravelers.keys.toList()[index]}');

                            /// Remove from controller's coTravelers list
                            controller.removeCoTraveler(state
                                .requireValue.coTravelers.keys
                                .toList()[index]);
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                      validator: (valueCandidate) =>
                          !focusNode.hasPrimaryFocus &&
                                  (valueCandidate?.isEmpty ?? true)
                              ? 'This field is required.'
                              : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    );
                  },
                  onSelected: (String selection) {
                    _currentFormState?.fields[
                            'coTravelerTextField-${state.requireValue.coTravelers.keys.toList()[index]}']
                        ?.didChange(selection);
                  },
                ),
              ),
            ),

            /// Button:
            /// ------ Add new co-traveler
            Center(
              child: IconButton(
                splashRadius: 25,
                icon: const Icon(Icons.add),
                color: Theme.of(context).primaryColor,
                onPressed: () => controller.addCoTraveler(
                    uuid.v4(), const CoTraveler(id: '', name: '')),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Locations',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),

            const SizedBox(height: 10),

            FormBuilderField<List<TripLocation>>(
              name: 'locations',
              /*onChanged: (value) =>
                        _currentFormState?.fields['locations']?.validate(),
                    validator: (value) => (value
                                ?.map((l) => l.name)
                                .contains('Select Location') ??
                            false)
                        ? 'This field is required.'
                        : null,*/
              builder: (field) => ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.requireValue.tripLocations.length,
                itemBuilder: (context, index) =>

                    /// ------ Form builder field
                    Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          GoRouter.of(context).push(RoutePaths.locationPicker,
                              extra: (lp.GeocodingResult? gr) {
                            TripLocation tripLocation =
                                state.requireValue.tripLocations[index];

                            if (gr != null) {
                              tripLocation = tripLocation.copyWith(
                                name: gr.formattedAddress,
                                location: LatLng(gr.geometry.location.lat,
                                    gr.geometry.location.lng),
                              );

                              controller.updateTripLocation(tripLocation);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 70,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.sizeOf(context).width * 0.5),
                                child: AutoSizeText(
                                  state.requireValue.tripLocations[index].name,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        /// Remove from tripLocations list
                        controller.removeTripLocation(
                            state.requireValue.tripLocations[index].id);
                      },
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Button:
            /// ------ Add new trip location
            Center(
              child: IconButton(
                splashRadius: 25,
                icon: const Icon(Icons.add),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  TripLocation newTripLocation = TripLocation(
                    id: uuid.v4(),
                    duration: const Duration(days: 2),
                    name: 'Select Location',
                    isVisited: false,
                    location: const LatLng(45, -42),
                  );

                  controller.addTripLocation(newTripLocation);

                  // _currentFormState?.setInternalFieldValue(
                  //     'locations', state.requireValue.tripLocations);
                },
              ),
            ),

            const SizedBox(height: 30),

            state.hasError
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        '${state.error}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    ),
                  )
                : const Offstage(),

            /// Buttons:
            Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: PrimaryButton(
                      text: 'Create',
                      isLoading: state.isLoading,
                      isDisabled: state.isLoading,
                      onPressed: () async {
                        try {
                          _currentFormState?.saveAndValidate();
                          for (MapEntry traveler
                              in state.requireValue.coTravelers.entries) {
                            if (userData.requireValue.username ==
                                    traveler.value.name ||
                                travelers.requireValue.firstWhereOrNull((t) =>
                                        t.username == traveler.value.name) ==
                                    null) {
                              _currentFormState?.fields[
                                      'coTravelerTextField-${traveler.key}']
                                  ?.invalidate('Username is invalid.');
                            }
                          }

                          if (state.requireValue.tripLocations
                              .map((l) => l.name)
                              .contains('Select Location')) {
                            controller.setError(
                                'One or more locations have not been set.\nPlease set the locations or remove them from the list.');
                            return;
                          }

                          List<String> coTravelersList = List.of(
                              _currentFormState?.value.entries
                                      .where((e) =>
                                          e.key.contains('coTravelerTextField'))
                                      .map((e) => e.value) ??
                                  []);

                          bool containsDuplicateCoTravelers =
                              coTravelersList.toSet().length !=
                                  coTravelersList.length;

                          if (containsDuplicateCoTravelers) {
                            controller.setError(
                                'Co-travelers list contains duplicate values.');
                            return;
                          }

                          if (_currentFormState?.isValid == true) {
                            final Map<String, dynamic> formData =
                                _currentFormState!.value;
                            await controller.createTripItinerary(formData);

                            GoRouter.of(context).pop();
                          }
                        } catch (e) {
                          log('Something went wrong with FB query: $e');
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                /// ------ Reset
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: PrimaryButton(
                      text: 'Reset',
                      isDisabled: state.isLoading,
                      onPressed: () {
                        _currentFormState?.reset();
                        controller.resetState();
                        // controller.removeUserTrips();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
