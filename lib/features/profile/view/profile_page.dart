import 'dart:developer';

import 'package:cinnamon_riverpod_2/features/profile/controller/profile_controller.dart';
import 'package:cinnamon_riverpod_2/features/profile/controller/profile_state.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/secondary_button.dart';
import 'package:cinnamon_riverpod_2/features/shared/dialogs/confirmation_dialog.dart';
import 'package:cinnamon_riverpod_2/helpers/snackbar_helper.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/traveler.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileController controller =
        ref.read(profileControllerProvider.notifier);
    final ProfileState state = ref.watch(profileControllerProvider);
    final AsyncValue<Traveler> profileData = ref.watch(profileDataProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).cardColor,
              child: Icon(
                Icons.person_outline_rounded,
                color: Theme.of(context).primaryColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              switch (profileData) {
                AsyncData<Traveler>(:final Traveler value) => value.name,
                AsyncError<Traveler>() => 'Username N/A',
                _ => '',
              },
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: state.loading
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  state.loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Column(
                          children: [
                            SecondaryButton(
                              text: 'Edit Profile',
                              onPressed: () => log('Edit Profile'),
                              fullWidthSpan: true,
                            ),
                            const SizedBox(height: 10),
                            SecondaryButton(
                              text: 'Settings',
                              onPressed: () => log('Settings'),
                              fullWidthSpan: true,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Push notifications',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Switch.adaptive(
                                  value: state.notificationsFlag,
                                  onChanged: (bool value) {
                                    try {
                                      controller.toggleNotifications(value);
                                    } catch (e) {
                                      SnackbarHelper.showTFSnackbar(context,
                                          'Failed to change the value. Please try again.');
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.1),
                            SecondaryButton(
                              text: 'Delete Account',
                              onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext ctx) =>
                                    ConfirmationDialog(
                                  title:
                                      'Are you sure you want to delete the account?',
                                  bodyText:
                                      'Deleting an account is irreversible, you will lose all of your account-related data.',
                                  onCancel: () => Navigator.pop(ctx),
                                  onConfirm: () async {
                                    GoRouter.of(ctx).pop();
                                    try {
                                      await controller.deleteUserAccount();
                                      GoRouter.of(context)
                                          .pushReplacement(RoutePaths.start);
                                    } catch (e) {
                                      log('E: ${e as FirebaseException}');
                                      SnackbarHelper.showTFSnackbar(
                                          context, '${e.message}');
                                    }
                                  },
                                ),
                              ),
                              fullWidthSpan: true,
                            ),
                            const SizedBox(height: 10),
                            SecondaryButton(
                              text: 'Log Out',
                              onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext ctx) =>
                                    ConfirmationDialog(
                                  bodyText: 'Are you sure you want to log out?',
                                  onCancel: () => Navigator.pop(ctx),
                                  onConfirm: () async {
                                    GoRouter.of(ctx).pop();
                                    if (await controller.logOut()) {
                                      GoRouter.of(context)
                                          .pushReplacement(RoutePaths.start);
                                    } else {
                                      SnackbarHelper.showTFSnackbar(context,
                                          'Log out failed. Please try again.');
                                    }
                                  },
                                ),
                              ),
                              fullWidthSpan: true,
                            ),
                          ],
                        ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
