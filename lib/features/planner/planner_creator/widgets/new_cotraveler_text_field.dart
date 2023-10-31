import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class NewCoTravelerTextField extends StatelessWidget {
  const NewCoTravelerTextField({
    super.key,
    required this.name,
    required this.coTravelers,
    this.onDelete,
  });

  final String name;
  final VoidCallback? onDelete;
  final List<String> coTravelers;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            /// Autocomplete text field - additional co-traveler
            Expanded(
              child: SizedBox(
                width: 290,
                child: FormBuilderField(
                  name: name,
                  builder: (FormFieldState field) => Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return coTravelers.where((String option) =>
                          option.contains(textEditingValue.text.toLowerCase()));
                    },
                    onSelected: (String selection) {
                      field.didChange(selection);
                      //  coTravelers.remove(selection);
                    },
                  ),
                  autovalidateMode: AutovalidateMode.always,
                ),
              ),
            ),
            /// Icon - Trash
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: onDelete,
            ),
          ],
        ),
      );
}
