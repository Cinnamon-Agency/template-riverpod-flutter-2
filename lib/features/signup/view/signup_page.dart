import 'package:cinnamon_riverpod_2/constants/constants.dart';
import 'package:cinnamon_riverpod_2/features/signup/controllers/signup_controller.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:cinnamon_riverpod_2/helpers/snackbar_helper.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/auth_result_handler.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_exceptions.dart';
import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cinnamon_riverpod_2/features/shared/buttons/primary_button.dart';

class SignupPage extends HookConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>(), const []);

    final controller = ref.read(signupControllerProvider.notifier);
    final state = ref.watch(signupControllerProvider);

    final formState = formKey.currentState;

    String email = formState?.fields['email']?.value ?? '';
    String name = formState?.fields['name']?.value ?? '';
    String password = formState?.fields['password']?.value ?? '';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  context.localization.signUpForAccount,
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: FormBuilder(
                  key: formKey,
                  onChanged: () {
                    /// Save the validation status each time a field has changed
                    /// to enable/disable the sign up button
                    controller.validateFields(formState?.isValid ?? false);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 24),
                          _buildFormField(formState, 'name', context.localization.username, [
                            FormBuilderValidators.required(),
                          ]),
                          const SizedBox(height: 24),
                          _buildFormField(formState, 'email', context.localization.email, [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                          const SizedBox(height: 24),
                          _buildFormField(formState, 'password', context.localization.password, [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.match(AppConstants.passwordRegex.pattern),
                          ]),
                          const SizedBox(height: 24),
                          _buildFormField(formState, 'confirm-password', context.localization.confirmPassword, [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.equal(password),
                          ]),
                          const SizedBox(height: 16),
                          Text(
                            context.localization.passwordRequirements,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      _buildButton(
                        PrimaryButton(
                          text: context.localization.signUp,
                          isLoading: state.isLoading,
                          onPressed: state.allFieldsValid
                              ? () async {
                                  try {
                                    await controller.triggerSignupWithEmail(
                                        email: email, password: password, username: name);
                                    GoRouter.of(context).pushAndRemoveUntil(RoutePaths.home);
                                  } on AuthException catch (e) {
                                    if (context.mounted) {
                                      SnackbarHelper.showTFSnackbar(context, e.localizedMessage(context));
                                    }
                                  } on TravelerException catch (e) {
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
      ),
    );
  }
}
