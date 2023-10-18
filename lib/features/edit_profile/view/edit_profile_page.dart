import 'package:cinnamon_riverpod_2/features/edit_profile/controller/edit_profile_controller.dart';
import 'package:cinnamon_riverpod_2/features/edit_profile/controller/edit_profile_state.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EditProfileController controller =
        ref.read(editProfileControllerProvider.notifier);
    final EditProfileState state = ref.watch(editProfileControllerProvider);

    final TextEditingController usernameTextController =
        useTextEditingController(text: state.username);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: GoRouter.of(context).pop,
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        elevation: 0.5,
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                controller: usernameTextController,
                onChanged: controller.onUsernameTextChange,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: PrimaryButton(
                  text: 'Submit changes',
                  onPressed: controller.onSubmit,
                  isLoading: state.loading,
                  isDisabled: !state.isUsernameValid,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
