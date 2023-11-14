import 'dart:developer';

import 'package:cinnamon_riverpod_2/features/planner/planner_creator/controller/planner_creation_controller.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/primary_button.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/cotraveler.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:collection/collection.dart';
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
                    itemCount: state.requireValue.coTravelers.length,
                    itemBuilder: (context, index) =>

                        /// ------ Form builder field
                        Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: FormBuilderField<String?>(
                        key: ValueKey(state.requireValue.coTravelers[index].id),
                        name:
                            'coTraveler-${state.requireValue.coTravelers[index].id}',
                        builder: (FormFieldState field) {
                          return Autocomplete<String>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) =>
                                    textEditingValue.text.isNotEmpty
                                        ? travelers.requireValue
                                            .map((e) => e.username)
                                            .where((String option) =>
                                                option !=
                                                    userData.requireValue
                                                        .username &&
                                                option.contains(textEditingValue
                                                    .text
                                                    .toLowerCase()))
                                        : [],
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController textEditingController,
                                FocusNode focusNode,
                                VoidCallback onFieldSubmitted) {
                              textEditingController.text =
                                  state.requireValue.coTravelers[index].name;
                              textEditingController.selection =
                                  TextSelection.collapsed(
                                      offset:
                                          textEditingController.text.length);
                              return FormBuilderTextField(
                                key: ValueKey(
                                    'textField-${state.requireValue.coTravelers[index].id}'),
                                name:
                                    'coTravelerTextField-${state.requireValue.coTravelers[index].id}',
                                controller: textEditingController,
                                focusNode: focusNode,
                                onChanged: (value) =>
                                    controller.updateCoTravelerName(
                                        state
                                            .requireValue.coTravelers[index].id,
                                        value ?? ''),
                                decoration: InputDecoration(
                                  labelText: 'Co-traveler',
                                  suffixIcon: IconButton(
                                    onPressed: () =>
                                        controller.removeCoTraveler(state
                                            .requireValue
                                            .coTravelers[index]
                                            .id),
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ),
                                validator: (valueCandidate) =>
                                    !focusNode.hasPrimaryFocus &&
                                            (valueCandidate?.isEmpty ?? true)
                                        ? 'This field is required.'
                                        : null,
                              );
                            },
                            onSelected: (String selection) {
                              field.didChange(selection);
                            },
                          );
                        },
                        autovalidateMode: AutovalidateMode.disabled,
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
                        onPressed: () => controller
                            .addCoTraveler(CoTraveler(id: uuid.v4(), name: '')),
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
