import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? title;
  final String bodyText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final String? onCancelText;
  final String? onConfirmText;

  const ConfirmationDialog({
    super.key,
    this.title,
    required this.bodyText,
    this.onCancel,
    this.onConfirm,
    this.onCancelText,
    this.onConfirmText,
  });

  @override
  Widget build(BuildContext context) => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
          constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.3),
          padding: const EdgeInsets.all(20),
          child: Wrap(
            direction: Axis.vertical,
            children: <Widget>[
              if (title != null)
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * 0.7),
                  child: AutoSizeText(
                    title!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              if (title != null) const Divider(),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.7),
                child: Text(
                  bodyText,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const Divider(),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.7,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    onCancel != null
                        ? Expanded(
                            child: InkWell(
                              onTap: onCancel,
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.25,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).colorScheme.error),
                                margin: const EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    onCancelText ?? context.localization.cancel,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    onConfirm != null
                        ? Expanded(
                            child: InkWell(
                              onTap: onConfirm,
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.25,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    onConfirmText ??
                                        context.localization.confirm,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
