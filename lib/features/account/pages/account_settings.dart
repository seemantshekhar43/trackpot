import 'package:flutter/material.dart';
import 'package:trackpot/core/styles/sizes.dart';
import 'package:trackpot/features/account/widgets/section_heading.dart';
import 'package:trackpot/features/account/widgets/settings_list_item.dart';

import '../../profile/presentation/pages/profile_page.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                radius: KSizes.circleImageAvatarRadiusSize,
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
            ),
            const SizedBox(
              height: KSizes.smd,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('John Doe',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(
                    height: KSizes.lg,
                    child: Icon(Icons.qr_code_2),
                  )
                ],
              ),
            ),
            Center(
              child: Text('johndoe@gmail.com',
                  style: Theme.of(context).textTheme.labelSmall),
            ),
            const SizedBox(
              height: KSizes.md,
            ),
            const Padding(
              padding: EdgeInsets.all(KSizes.md),
              child: SectionHeading(label: 'Profile'),
            ),
            SettingsListItem(
              icon: Icons.person,
              title: 'My profile',
              onTap: () => {
                Navigator.push(context, ProfilePage.route())
              },
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(KSizes.md),
              child: SectionHeading(label: 'Preferences'),
            ),
            SettingsListItem(
              icon: Icons.notifications,
              title: 'Push notification',
              onTap: () => {},
            ),
            const Divider(),
            SettingsListItem(
              icon: Icons.email,
              title: 'Email notifications',
              onTap: () => {},
            ),
            const Divider(),
            SettingsListItem(
              icon: Icons.brightness_6_rounded,
              title: 'App theme',
              onTap: () => {},
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(KSizes.md),
              child: SectionHeading(label: 'Security'),
            ),
            SettingsListItem(
              icon: Icons.fingerprint,
              title: 'Screen lock',
              onTap: () => {},
            ),
            const Divider(),
            SettingsListItem(
              icon: Icons.key,
              title: 'Change password',
              onTap: () => {},
            ),
            const Divider(),
            SettingsListItem(
              icon: Icons.star_rate_outlined,
              title: 'Rate Trackpot',
              onTap: () => {},
            ),
            const Divider(),
            SettingsListItem(
              icon: Icons.favorite_border,
              title: 'Tell a friend',
              onTap: () => {},
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(KSizes.md),
              child: SectionHeading(label: 'Trackpot'),
            ),
            SettingsListItem(
              icon: Icons.info,
              title: 'About us',
              onTap: () => {},
            ),
            const Divider(),
            SettingsListItem(
              icon: Icons.star_rate_outlined,
              title: 'Rate Trackpot',
              onTap: () => {},
            ),
            const Divider(),
            SettingsListItem(
              icon: Icons.favorite_border,
              title: 'Tell a friend',
              onTap: () => {},
            ),
            const Divider(),
            SettingsListItem(
              icon: Icons.mail,
              title: 'Trackpot Support',
              onTap: () => {},
            ),
            const Divider(),
            const SizedBox(
              height: KSizes.md,
            ),
            Center(
              child: Text('Log Out',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
            const SizedBox(
              height: KSizes.md,
            ),

          ],
        ),
      ),
    ));
  }
}
