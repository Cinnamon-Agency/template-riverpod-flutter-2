import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinnamon_riverpod_2/theme/colors/light_app_colors.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as provider;
import 'package:cinnamon_riverpod_2/features/planner/trip_creator/controller/location_index_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_creator/controller/trip_creation_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_state.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/primary_button.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/osm_location.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/cotraveler.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

import 'package:cinnamon_riverpod_2/gen/assets.gen.dart';

import '../controller/trip_cover_photo_controller.dart';

class TripCreatorForm extends ConsumerStatefulWidget {
  const TripCreatorForm({this.editTripItineraryId});

  final String? editTripItineraryId;

  @override
  ConsumerState<TripCreatorForm> createState() => _TripCreatorFormState();
}

class _TripCreatorFormState extends ConsumerState<TripCreatorForm> {
  TripDetailsController? editController;
  AsyncValue<TripDetailsState>? editState;

  final _formKey = GlobalKey<FormBuilderState>();
  final _nameNode = FocusNode();
  final _descriptionNode = FocusNode();
  final uuid = const Uuid();
  final _nameTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _startDateTextController = TextEditingController();
  final _endDateTextController = TextEditingController();
  late final bool _isEditing;

  FormBuilderState? get _currentFormState => _formKey.currentState;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.editTripItineraryId != null;
    // set initial values if editing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isEditing && editState!.hasValue) {
        _nameTextController.text = editState!.value!.tripItinerary.name;
        _descriptionTextController.text = editState!.value!.tripItinerary.description;
        _startDateTextController.text = editState!.value!.tripItinerary.startDate.dateString;
        _endDateTextController.text = editState!.value!.tripItinerary.endDate.dateString;
        ref.read(tripCreationStateProvider.notifier).setInitialValuesWhenEditing(uuid, editState!.value!.tripItinerary);
      }
    });
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _descriptionTextController.dispose();
    _startDateTextController.dispose();
    _endDateTextController.dispose();
    super.dispose();
  }

  void showDatePickerDialog(TextEditingController textEditingController) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now().subtract(const Duration(days: 365)),
      maxTime: DateTime.now().add(const Duration(days: 365 * 3)),
      onConfirm: (date) {
        textEditingController.text = date.dateString;
      },
      currentTime: textEditingController.text.isEmpty ? DateTime.now() : textEditingController.text.toDateTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    // coTravelers and locations
    final controller = ref.read(tripCreationStateProvider.notifier);
    var state = ref.watch(tripCreationStateProvider);
    // coverPhoto
    final coverPhotoController = ref.read(coverPhotoProvider.notifier);
    var coverPhotoState = ref.watch(coverPhotoProvider);
    final userData = ref.watch(profileDataProvider);
    final travelers = ref.watch(travelersProvider);

    // ----------- editing tripItinerary
    if (_isEditing) {
      editController = ref.read(tripDetailsControllerProvider(widget.editTripItineraryId!).notifier);
      editState = ref.watch(tripDetailsControllerProvider(widget.editTripItineraryId!));
    }
    ref.listen<AsyncValue>(
      tripCreationStateProvider,
      (_, state) => state.showSnackbarOnError(context),
    );
    ref.listen<AsyncValue>(
      coverPhotoProvider,
          (_, state) => state.showSnackbarOnError(context),
    );
    return FormBuilder(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// ---TRIP COVER PHOTO
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: () => coverPhotoController.pickImage(),
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: lightAppColors.neutralsWhite,
                  backgroundImage: provider.Svg(
                    Assets.images.travelling,
                  ),
                  foregroundImage: (coverPhotoState.requireValue.imagePath ?? '').isEmpty
                      ? null
                      : Image.file(
                          coverPhotoState.requireValue.coverPhotoFile!,
                          fit: BoxFit.cover,
                        ).image,
                  child: _isEditing && editState!.hasValue
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: editState!.value!.tripItinerary.imageUrl ?? '',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          Icons.camera_alt,
                          color: lightAppColors.primary600,
                          size: 38,
                        ),
                ),
              ),
            ),

            /// --- NAME
            const SizedBox(
              height: 20,
            ),

            FormBuilderTextField(
              name: 'name',
              focusNode: _nameNode,
              textCapitalization: TextCapitalization.words,
              controller: _nameTextController,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) => _currentFormState?.fields['name']?.validate(),
              validator: (value) =>
                  /*!_nameNode.hasPrimaryFocus && */ (value?.isEmpty ?? true) ? 'This field is required.' : null,
            ),

            const SizedBox(
              height: 20,
            ),

            /// ----------- DESCRIPTION
            FormBuilderTextField(
              name: 'description',
              focusNode: _descriptionNode,
              controller: _descriptionTextController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: false,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
              ),
              onChanged: (value) => _currentFormState?.fields['description']?.validate(),
              validator: (value) =>
                  /*!_descriptionNode.hasPrimaryFocus && */ (value?.isEmpty ?? true) ? 'This field is required.' : null,
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// ----------- START DATE
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: FormBuilderTextField(
                    name: 'start_date',
                    controller: _startDateTextController,
                    readOnly: true,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                    ),
                    onChanged: (value) => _currentFormState?.fields['start_date']?.validate(),
                    validator: (value) => (value?.isEmpty ?? true) ? 'This field is required.' : null,
                    onTap: () {
                      showDatePickerDialog(_startDateTextController);
                    },
                  ),
                ),

                /// ----------- END DATE
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: FormBuilderTextField(
                    name: 'end_date',
                    controller: _endDateTextController,
                    readOnly: true,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                    ),
                    onChanged: (value) => _currentFormState?.fields['end_date']?.validate(),
                    validator: (value) => (value?.isEmpty ?? true) ? 'This field is required.' : null,
                    onTap: () {
                      showDatePickerDialog(_endDateTextController);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              'Co-travelers',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).primaryColor),
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
                  key: ValueKey('coTraveler-${state.requireValue.coTravelers.keys.toList()[index]}'),
                  optionsBuilder: (TextEditingValue textEditingValue) =>
                      textEditingValue.text.isNotEmpty && travelers.hasValue
                          ? travelers.requireValue.map((e) => e.username).where((String option) =>
                              option != userData.requireValue.username &&
                              option.contains(textEditingValue.text.toLowerCase()))
                          : [],
                  fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
                      FocusNode focusNode, VoidCallback onFieldSubmitted) {
                    if (textEditingController.text != state.requireValue.coTravelers.values.toList()[index].name) {
                      textEditingController.text = state.requireValue.coTravelers.values.toList()[index].name;
                      textEditingController.selection =
                          TextSelection.collapsed(offset: textEditingController.text.length);
                    }
                    return FormBuilderTextField(
                      key: ValueKey('coTravelerTextField-${state.requireValue.coTravelers.keys.toList()[index]}'),
                      name: 'coTravelerTextField-${state.requireValue.coTravelers.keys.toList()[index]}',
                      controller: textEditingController,
                      focusNode: focusNode,
                      onChanged: (value) {
                        controller.updateCoTravelerName(state.requireValue.coTravelers.keys.toList()[index],
                            travelers.requireValue.firstWhereOrNull((t) => t.username == value)?.id ?? '', value ?? '');
                        _currentFormState
                            ?.fields['coTravelerTextField-${state.requireValue.coTravelers.keys.toList()[index]}']
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
                            controller.removeCoTraveler(state.requireValue.coTravelers.keys.toList()[index]);
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                      validator: (valueCandidate) => !focusNode.hasPrimaryFocus && (valueCandidate?.isEmpty ?? true)
                          ? 'This field is required.'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    );
                  },
                  onSelected: (String selection) {
                    _currentFormState
                        ?.fields['coTravelerTextField-${state.requireValue.coTravelers.keys.toList()[index]}']
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
                onPressed: () => controller.addCoTraveler(uuid.v4(), const CoTraveler(id: '', name: '')),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Locations',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).primaryColor),
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
                          ref.read(indexProvider.notifier).setIndex(index);
                          GoRouter.of(context).push(RoutePaths.locationPicker, extra: (OsmLocation? location) async {
                            TripLocation tripLocation = state.requireValue.tripLocations[index];
                            if (location != null) {
                              final locationName = location.name.isNotEmpty
                                  ? location.name
                                  : location.displayName.isNotEmpty
                                      ? location.displayName
                                      : 'Name not provided by api';
                              tripLocation = tripLocation.copyWith(
                                name: locationName,
                                location:
                                    LatLng(double.tryParse(location.lat) ?? 0.0, double.tryParse(location.lng) ?? 0.0),
                                // todo duration: duration
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
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.5),
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
                        controller.removeTripLocation(state.requireValue.tripLocations[index].id);
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
                      text: _isEditing ? 'Save' : 'Create',
                      isLoading: state.isLoading,
                      isDisabled: state.isLoading,
                      onPressed: () async {
                        try {
                          _currentFormState?.saveAndValidate();
                          for (MapEntry traveler in state.requireValue.coTravelers.entries) {
                            if (userData.requireValue.username == traveler.value.name ||
                                travelers.requireValue.firstWhereOrNull((t) => t.username == traveler.value.name) ==
                                    null) {
                              _currentFormState?.fields['coTravelerTextField-${traveler.key}']
                                  ?.invalidate('Username is invalid.');
                            }
                          }

                          if (state.requireValue.tripLocations.map((l) => l.name).contains('Select Location')) {
                            controller.setError(
                                'One or more locations have not been set.\nPlease set the locations or remove them from the list.');
                            return;
                          }

                          List<String> coTravelersList = List.of(_currentFormState?.value.entries
                                  .where((e) => e.key.contains('coTravelerTextField'))
                                  .map((e) => e.value) ??
                              []);

                          bool containsDuplicateCoTravelers = coTravelersList.toSet().length != coTravelersList.length;

                          if (containsDuplicateCoTravelers) {
                            controller.setError('Co-travelers list contains duplicate values.');
                            return;
                          }

                          if (_currentFormState?.isValid == true) {
                            if (_isEditing) {
                              TripItinerary updatedTripItinerary = editState!.value!.tripItinerary.copyWith(
                                name: _nameTextController.text,
                                description: _descriptionTextController.text,
                                startDate: _startDateTextController.text.toDateTime,
                                endDate: _endDateTextController.text.toDateTime,
                                travelers: [
                                  CoTraveler(id: userData.requireValue.id, name: userData.requireValue.username),
                                  ...state.requireValue.coTravelers.values
                                ],
                                locations: state.requireValue.tripLocations,
                              );
                              await controller.updateTripItinerary(updatedTripItinerary);
                            } else {
                              final Map<String, dynamic> formData = _currentFormState!.value;
                              await controller.createTripItinerary(formData);
                            }

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
                      text: _isEditing ? 'Cancel' : 'Reset',
                      isDisabled: state.isLoading,
                      onPressed: _isEditing
                          ? GoRouter.of(context).pop
                          : () {
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
