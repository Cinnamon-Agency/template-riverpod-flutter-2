import 'dart:developer';

import 'package:cinnamon_riverpod_2/features/planner/planner_creator/controller/planner_creation_controller.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/primary_button.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/firebase_auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:uuid/uuid.dart';

class PlannerCreatorForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final _nameNode = FocusNode();
  final _descriptionNode = FocusNode();
  final uuid = const Uuid();

  // final _coTravelerNode = FocusNode();

  /// TODO: Get all travelers from BE
  static const List<String> kCoTravelersOptions = <String>[
    'pikachu',
    'bulbasaur',
    'charmander',
    'squirtle',
    'caterpie',
  ];

  static const List<String> coTravelersOptions = <String>[
    'pikachu',
    'bulbasaur',
    'charmander',
    'squirtle',
    'caterpie',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(plannerCreationStateProvider.notifier);
    final state = ref.watch(plannerCreationStateProvider);
    final userId = ref.read(userIdProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create new trip'),
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
                    shrinkWrap: true,
                    itemCount: state.requireValue.coTravelersCount,
                    itemBuilder: (context, index) =>

                        /// ------ Form builder field
                        Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: FormBuilderField<String?>(
                        name: 'coTraveler-${uuid.v4()}',
                        builder: (FormFieldState field) {
                          return Autocomplete<String>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) =>
                                    coTravelersOptions.where((String option) =>
                                        option.contains(textEditingValue.text
                                            .toLowerCase())),
                            fieldViewBuilder: (BuildContext context,
                                    TextEditingController textEditingController,
                                    FocusNode focusNode,
                                    VoidCallback onFieldSubmitted) =>
                                FormBuilderTextField(
                              name: 'coTravelerTextField-${uuid.v4()}',
                              controller: textEditingController,
                              focusNode: focusNode,
                              onChanged: (value) {
                                /// if current value is complete®ly deleted, get its value back to the options list
                                if (value!.isEmpty) {
                                  /*if (kCoTravelersOptions.contains(
                                      savedValue) &&
                                      !coTravelersOptions.contains(
                                          savedValue)) {
                                    coTravelersOptions.add(savedValue);
                                  }*/
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: 'Co-traveler',
                                  icon: IconButton(
                                      onPressed: () {
                                        // focusNode.dispose();
                                        // textEditingController.dispose();
                                        controller.updateCoTravelersCount((state
                                                    .requireValue
                                                    .coTravelersCount ??
                                                0) -
                                            1);
                                      },
                                      icon: const Icon(Icons.delete_outline))),
                              validator: (valueCandidate) =>
                                  !focusNode.hasPrimaryFocus &&
                                          (valueCandidate?.isEmpty ?? true)
                                      ? 'This field is required.'
                                      : null,
                            ),
                            onSelected: (String selection) {
                              field.didChange(selection);
                            },
                          );
                        },
                        autovalidateMode: AutovalidateMode.always,
                        validator: FormBuilderValidators.required(),
                      ),
                    ),
                  ),

                  /// Button:
                  /// ------ Add new co-traveler
                  Center(
                    child: SizedBox(
                      height: 50,
                      child: PrimaryButton(
                        text: '+',
                        onPressed: () => controller.updateCoTravelersCount(
                            (state.requireValue.coTravelersCount ?? 0) + 1),
                      ),
                    ),
                  ),
                  /* Center(
                    child: MaterialButton(
                        color: Theme.of(context).primaryColor,
                        child: const Text(
                          "Add new co-traveler",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          /// save current state
                          _formKey.currentState?.save();
                          // log('FORM STATE ====> ${_formKey.currentState?.value}');
                          // _formKey.currentState?.setInternalFieldValue(
                          //     'coTravelersCount',
                          //     _formKey.currentState?.value['coTravelersCount'] +
                          //         1);
                          // _formKey.currentState?.save();

                          controller.updateCoTravelersCount(
                              (state.requireValue.coTravelersCount ?? 0) + 1);

                          /// if additional co-travelers fields are added - get the value of the lastly added field
                          // if (fields.isNotEmpty) {
                          //   savedValue = _formKey.currentState
                          //       ?.value['coTraveler_${fields.length - 1}'];
                          // }

                          /// if added value is from the options list - remove it from the options list
                          // if (coTravelersOptions.contains(savedValue)) {
                          //   coTravelersOptions.remove(savedValue);
                          //   savedValue = '';
                          // }

                          /// check if the first co-traveler text field is filled
                          */ /*if (_formKey.currentState?.value['coTraveler'] !=
                              null) {
                            if ((_formKey.currentState?.value['coTraveler']
                                        .isNotEmpty &&
                                    fields.isEmpty) ||
                                checkIfNewFieldAllowed()) {
                              setState(() {
                                fields.add(
                                  NewCoTravelerTextField(
                                    name: 'coTraveler_${fields.length}',
                                    coTravelers: coTravelersOptions,
                                    onDelete: () {
                                      setState(() {
                                        if (kCoTravelersOptions.contains(_formKey
                                                    .currentState?.value[
                                                'coTraveler_${fields.length - 1}']) &&
                                            !coTravelersOptions.contains(_formKey
                                                    .currentState?.value[
                                                'coTraveler_${fields.length - 1}'])) {
                                          coTravelersOptions.add(_formKey
                                                  .currentState?.value[
                                              'coTraveler_${fields.length - 1}']);
                                        } else {
                                          setState(() {
                                            savedValue = _formKey.currentState
                                                ?.value['coTraveler'];
                                          });
                                        }

                                        fields.removeAt(fields.length - 1);
                                      });
                                    },
                                  ),
                                );
                              });
                            }
                          }*/ /*
                        }),
                  ),*/

                  const SizedBox(height: 30),

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
                                log('FORM FIELDS ===> ${_formKey.currentState?.value}');
                                await controller
                                    .createTripItinerary(TripItineraryEntity(
                                  id: '',
                                  name: "Trip to Zagreb",
                                  description: "Going to ZG, HR",
                                  locations: [],
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1572455044327-7348c1be7267?auto=format&fit=crop&q=80&w=3603&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  startDate: DateTime(2024, 2, 1),
                                  endDate: DateTime(2024, 2, 15),
                                  ownerIds: [userId],
                                ));
                                log('============= AFTER SENDING TRIP ================');
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
                            onPressed: () {
                              /// reset current state
                              _formKey.currentState!.reset();
                            },
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
