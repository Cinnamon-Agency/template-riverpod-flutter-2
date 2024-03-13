import 'package:cinnamon_riverpod_2/features/login/controllers/login_controller.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:cinnamon_riverpod_2/helpers/snackbar_helper.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/auth_result_handler.dart';
import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cinnamon_riverpod_2/features/shared/buttons/primary_button.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>(), const []);

    final controller = ref.read(loginControllerProvider.notifier);
    final state = ref.watch(loginControllerProvider);

    final formState = formKey.currentState;

    String email = formState?.fields['email']?.value ?? '';
    String password = formState?.fields['password']?.value ?? '';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  context.localization.logInToAccount,
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: FormBuilder(
                  key: formKey,
                  onChanged: () {
                    /// Save the validation status each time a field has changed
                    /// to enable/disable the log in button
                    controller.validateFields(formState?.isValid ?? false);
                  },
                  child: AutofillGroup(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 32),
                            _buildFormField(
                              formState,
                              'email',
                              context.localization.email,
                              [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(),
                              ],
                              autofillHints: [AutofillHints.email],
                            ),
                            const SizedBox(height: 32),
                            _buildFormField(
                              formState,
                              'password',
                              context.localization.password,
                              [
                                FormBuilderValidators.required(),
                              ],
                              autofillHints: [AutofillHints.password],
                            ),
                          ],
                        ),
                        _buildButton(
                          PrimaryButton(
                            text: context.localization.logIn,
                            isLoading: state.isLoading,
                            onPressed: state.allFieldsValid
                                ? () async {
                                    // Finish autofill
                                    TextInput.finishAutofillContext();
                                    try {
                                      await controller.triggerLoginWithEmail(email: email, password: password);
                                      GoRouter.of(context).pushAndRemoveUntil(RoutePaths.home);
                                    } on AuthException catch (e) {
                                      if (context.mounted) {
                                        SnackbarHelper.showTFSnackbar(context, e.localizedMessage(context));
                                      }
                                    }
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(Widget button) {
    return Container(
      height: 48,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: button,
    );
  }

  Widget _buildFormField(
    FormBuilderState? formState,
    String fieldName,
    String fieldLabel,
    List<String? Function(String?)> formValidators, {
    bool obscureText = false,
    Iterable<String> autofillHints = const [],
  }) {
    return Focus(
      onFocusChange: (focus) {
        /// Trigger a validation of the field each time it loses focus.
        /// This is a workaround, as using FormBuilder's autoValidate mode
        /// triggers a validation of all fields (even if they haven't been filled yet).
        if (focus == false) {
          formState?.fields[fieldName]?.validate(focusOnInvalid: false);
        }
      },
      child: FormBuilderTextField(
        name: fieldName,
        decoration: InputDecoration(labelText: fieldLabel),
        obscureText: obscureText,
        autocorrect: false,
        validator: FormBuilderValidators.compose(formValidators),
        autofillHints: autofillHints,
      ),
    );
  }
}
