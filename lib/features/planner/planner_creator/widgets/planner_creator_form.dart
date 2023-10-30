import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'new_cotraveler_text_field.dart';

class PlannerCreatorForm extends StatefulWidget {
  const PlannerCreatorForm({Key? key}) : super(key: key);

  @override
  State<PlannerCreatorForm> createState() => _PlannerCreatorFormState();
}

class _PlannerCreatorFormState extends State<PlannerCreatorForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  /// TODO: Get all travelers from BE
  static const List<String> coTravelers = <String>[
    'pikachu',
    'bulbasaur',
    'charmander',
    'squirtle',
    'caterpie',
  ];

  final List<Widget> fields = [];
  String savedValue = '';

  @override
  void initState() {
    savedValue = _formKey.currentState?.value.toString() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// --- NAME
              /// --------- Title
              Text(
                'Destination name',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 10,
              ),

              /// ---------- Text field
              FormBuilderTextField(
                name: 'name',
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (valueCandidate) {
                  if (valueCandidate?.isEmpty ?? true) {
                    return 'This field is required.';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 20,
              ),

              /// ----------- DESCRIPTION
              /// --------- Title
              Text(
                'Destination description',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 10,
              ),

              /// ------- Text field
              FormBuilderTextField(
                name: 'description',
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                ),
                validator: (valueCandidate) {
                  if (valueCandidate?.isEmpty ?? true) {
                    return 'This field is required.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// ----------- CO TRAVELER(S)
              /// --------- Title
              Text(
                'Co-traveler(s)',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 10,
              ),

              /// ------ Form builder field
              SizedBox(
                width: fields.isNotEmpty ? 290 : null,
                child: FormBuilderField<String?>(
                  name: 'coTraveler',
                  builder: (FormFieldState field) {
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return coTravelers.where((String option) {
                          return option
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      fieldViewBuilder: (BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) =>
                          FormBuilderTextField(
                        name: 'coTraveler',
                        controller: textEditingController,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          labelText: 'Co-traveler',
                        ),
                        validator: (valueCandidate) {
                          if (valueCandidate?.isEmpty ?? true) {
                            return 'This field is required.';
                          }
                          return null;
                        },
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
              ...fields,

              /// Button:
              /// ------ Add new co-traveler
              const SizedBox(height: 20),
              Center(
                child: MaterialButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text(
                    "Add new co-traveler",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      fields.add(
                        NewCoTravlerTextField(
                          name: 'coTraveler_${fields.length}',
                          coTravelers: coTravelers,
                          onDelete: () {
                            setState(() {
                              fields.removeAt(fields.length - 1);
                            });
                          },
                        ),
                      );
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),

              /// Buttons:

              Row(
                children: <Widget>[
                  /// ------ Create
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).primaryColor,
                      child: const Text(
                        'Create',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          debugPrint(_formKey.currentState!.value.toString());
                        } else {
                          debugPrint("validation failed");
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 20),

                  /// ------ Reset
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).primaryColor,
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


