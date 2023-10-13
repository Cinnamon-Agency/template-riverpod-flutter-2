import 'dart:developer';

import 'package:cinnamon_riverpod_2/features/shared/buttons/secondary_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => Container(
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
              'Username',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            SecondaryButton(
              text: 'Edit Profile',
              onPressed: () => log('Edit Profile'),
              fullWidthSpan: true,
            ),
            const SizedBox(height: 10),
            SecondaryButton(
              text: 'Notifications',
              onPressed: () => log('Notification settings'),
              fullWidthSpan: true,
            ),
            const SizedBox(height: 10),
            SecondaryButton(
              text: 'Settings',
              onPressed: () => log('Settings'),
              fullWidthSpan: true,
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
            SecondaryButton(
              text: 'Delete Account',
              onPressed: () => log('Delete Account'),
              fullWidthSpan: true,
            ),
            const SizedBox(height: 10),
            SecondaryButton(
              text: 'Log Out',
              onPressed: () => log('Log Out'),
              fullWidthSpan: true,
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
}
