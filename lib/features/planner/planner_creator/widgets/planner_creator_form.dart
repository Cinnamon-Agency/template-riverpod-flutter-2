import 'dart:developer';

import 'package:cinnamon_riverpod_2/features/planner/planner_creator/controller/planner_creation_controller.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/primary_button.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/cotraveler.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class PlannerCreatorForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final _nameNode = FocusNode();
  final _descriptionNode = FocusNode();
  final uuid = const Uuid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(plannerCreationStateProvider.notifier);
    final state = ref.watch(plannerCreationStateProvider);
    final userData = ref.watch(profileDataProvider);
    final travelers = ref.watch(travelersProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create a new trip'),
          leading: InkWell(
            onTap: Navigator.of(context).pop,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FormBuilder(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// --- NAME
                  const SizedBox(
                    height: 10,
                  ),

                  /// ---------- Text field
                  FormBuilderTextField(
                    name: 'name',
                    focusNode: _nameNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    onChanged: (value) =>
                        _formKey.currentState?.fields['name']?.validate(),
                    validator: (value) =>
                        !_nameNode.hasPrimaryFocus && (value?.isEmpty ?? true)
                            ? 'This field is required.'
                            : null,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  /// ----------- DESCRIPTION
                  const SizedBox(
                    height: 10,
                  ),

                  /// ------- Text field
                  FormBuilderTextField(
                    name: 'description',
                    focusNode: _descriptionNode,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      alignLabelWithHint: true,
                    ),
                    onChanged: (value) => _formKey
                        .currentState?.fields['description']
                        ?.validate(),
                    validator: (value) => !_descriptionNode.hasPrimaryFocus &&
                            (value?.isEmpty ?? true)
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
                            'coTraveler-${state.requireValue.coTravelers[index].id}'),
                        optionsBuilder: (TextEditingValue textEditingValue) =>
                            textEditingValue.text.isNotEmpty
                                ? travelers.requireValue
                                    .map((e) => e.username)
                                    .where((String option) =>
                                        option !=
                                            userData.requireValue.username &&
                                        option.contains(textEditingValue.text
                                            .toLowerCase()))
                                : [],
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted) {
                          if (textEditingController.text !=
                              state.requireValue.coTravelers[index].name) {
                            textEditingController.text =
                                state.requireValue.coTravelers[index].name;
                            textEditingController.selection =
                                TextSelection.collapsed(
                                    offset: textEditingController.text.length);
                          }
                          return FormBuilderTextField(
                            key: ValueKey(
                                'coTravelerTextField-${state.requireValue.coTravelers[index].id}'),
                            name:
                                'coTravelerTextField-${state.requireValue.coTravelers[index].id}',
                            controller: textEditingController,
                            focusNode: focusNode,
                            onChanged: (value) {
                              controller.updateCoTravelerName(
                                  state.requireValue.coTravelers[index].id,
                                  value ?? '');
                              _formKey
                                  .currentState
                                  ?.fields[
                                      'coTravelerTextField-${state.requireValue.coTravelers[index].id}']
                                  ?.validate();
                            },
                            decoration: InputDecoration(
                              labelText: 'Co-traveler',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  /// Remove form fields
                                  _formKey.currentState?.removeInternalFieldValue(
                                      'coTravelerTextField-${state.requireValue.coTravelers[index].id}');

                                  log('FORM FIELDS ===> ${_formKey.currentState?.fields}');

                                  /// Remove from controller's coTravelers list
                                  controller.removeCoTraveler(
                                      state.requireValue.coTravelers[index].id);
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          );
                        },
                        onSelected: (String selection) {
                          _formKey
                              .currentState
                              ?.fields[
                                  'coTravelerTextField-${state.requireValue.coTravelers[index].id}']
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
                      onPressed: () => controller
                          .addCoTraveler(CoTraveler(id: uuid.v4(), name: '')),
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

                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: state.requireValue.tripLocations.length,
                    itemBuilder: (context, index) =>

                        /// ------ Form builder field
                        Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: FormBuilderTextField(
                        key: ValueKey(
                            'location-${state.requireValue.tripLocations[index].id}'),
                        name:
                            'locationTextField-${state.requireValue.tripLocations[index].id}',
                        readOnly: true,
                        onChanged: (value) {
                          _formKey
                              .currentState
                              ?.fields[
                                  'locationTextField-${state.requireValue.tripLocations[index].id}']
                              ?.validate();
                        },
                        decoration: InputDecoration(
                          labelText: 'Location',
                          suffixIcon: IconButton(
                            onPressed: () {
                              /// Remove form fields
                              _formKey.currentState?.removeInternalFieldValue(
                                  'location-${state.requireValue.tripLocations[index].id}');
                              _formKey.currentState?.removeInternalFieldValue(
                                  'locationTextField-${state.requireValue.tripLocations[index].id}');

                              /// Remove from tripLocations list
                              controller.removeTripLocation(
                                  state.requireValue.tripLocations[index].id);
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                        validator: (valueCandidate) =>
                            (valueCandidate?.isEmpty ?? true)
                                ? 'This field is required.'
                                : null,
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
                      onPressed: () => controller.addTripLocation(
                        TripLocation(
                          id: uuid.v4(),
                          duration: const Duration(days: 2),
                          name: 'New York',
                          isVisited: false,
                          location: const LatLng(45, -42),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  state.hasError
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              '${state.error}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
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
                                _formKey.currentState?.saveAndValidate();
                                for (var traveler
                                    in state.requireValue.coTravelers) {
                                  if (userData.requireValue.username ==
                                          traveler.name ||
                                      travelers.requireValue.firstWhereOrNull(
                                              (t) =>
                                                  t.username ==
                                                  traveler.name) ==
                                          null) {
                                    _formKey
                                        .currentState
                                        ?.fields[
                                            'coTravelerTextField-${traveler.id}']
                                        ?.invalidate('Username is invalid.');
                                  }
                                }

                                bool containsDuplicateCoTravelers = _formKey
                                        .currentState?.value.values
                                        .toSet()
                                        .length !=
                                    _formKey.currentState?.value.values.length;

                                if (containsDuplicateCoTravelers) {
                                  controller.setError(
                                      'Co-travelers list contains duplicate values.');
                                  return;
                                }

                                log('FORM STATE ===> ${_formKey.currentState?.value}');

                                if (_formKey.currentState?.isValid == true) {
                                  final Map<String, dynamic> formData =
                                      _formKey.currentState!.value;
                                  await controller
                                      .createTripItinerary(formData)
                                      .then((value) =>

                                          // TODO: Handle error states in more detail if necessary
                                          _formKey.currentState!.reset());
                                }
                              } catch (e) {
                                log('Something went wrong with FB query.');
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
                            onPressed:
                                () => /*controller
                                .removeUserTrips() */
                                    _formKey.currentState?.reset(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
