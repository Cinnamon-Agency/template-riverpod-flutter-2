import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String bodyText;
  final VoidCallback? onOk;
  final String? onOkText;

  const SuccessDialog({
    super.key,
    required this.bodyText,
    this.onOk,
    this.onOkText,
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
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 15,
          ),
          child: Wrap(
            children: <Widget>[
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 0.7),
                        child: AutoSizeText(
                          context.localization.success,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.7),
                child: AutoSizeText(
                  bodyText,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 4,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.7,
                  ),
                  child: InkWell(
                    onTap: onOk ?? () => Navigator.pop(context),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.25,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          onOkText ?? context.localization.ok,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
