import 'package:cinnamon_riverpod_2/features/shared/primary_button.dart';
import 'package:cinnamon_riverpod_2/features/signup/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupPage extends HookConsumerWidget {
  SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>(), const []);

    final controller = ref.watch(signupControllerProvider.notifier);
    final state = ref.watch(signupControllerProvider);

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
                  'Sign up for a TripFinder account',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Expanded(
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 32),
                          FormBuilderTextField(
                            name: 'email',
                            decoration: const InputDecoration(labelText: 'Email'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              // FormBuilderValidators.email(),
                            ]),
                            onChanged: (_) {
                              controller.validateFields(formState?.isValid ?? false);
                            },
                          ),
                          const SizedBox(height: 32),
                          FormBuilderTextField(
                            name: 'password',
                            decoration: const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            onChanged: (_) {
                              controller.validateFields(formState?.isValid ?? false);
                            },
                          ),
                        ],
                      ),
                      _buildButton(
                        PrimaryButton(
                          text: 'Sign up',
                          onPressed: state.allFieldsValid
                              ? () => controller.triggerSignupWithEmail(email: email, password: password)
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
}
