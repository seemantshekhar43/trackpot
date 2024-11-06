import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/profile_constants.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/list_divider.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';
import '../widgets/profile_avatar.dart';
import '../../../core/widgets/section_heading.dart';
import '../widgets/settings_list_item.dart';

import '../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../core/common/entities/user.dart';
import '../../profile/presentation/pages/profile_page.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, appUserState) {
        if (appUserState is AppUserAuthenticated) {
          final User user = appUserState.user;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Account',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0.0,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: ProfileAvatar(
                      imageId: user.profilePicture,
                      radius: KSizes.circleImageAvatarRadiusSize,
                      userInitials: ProfileConstants.userInitials(firstName: user.firstName),
                    )),
                    const SizedBox(
                      height: KSizes.smd,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${user.firstName} ${user.lastName}',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(
                            height: KSizes.lg,
                            child: Icon(Icons.qr_code_2),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Text(user.email,
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
                      onTap: () =>
                          {Navigator.push(context, ProfilePage.route())},
                    ),
                    const ListDivider(),
                    const Padding(
                      padding: EdgeInsets.all(KSizes.md),
                      child: SectionHeading(label: 'Preferences'),
                    ),
                    SettingsListItem(
                      icon: Icons.notifications,
                      title: 'Push notification',
                      onTap: () => {},
                    ),
                    const ListDivider(),
                    SettingsListItem(
                      icon: Icons.email,
                      title: 'Email notifications',
                      onTap: () => {},
                    ),
                    const ListDivider(),
                    SettingsListItem(
                      icon: Icons.brightness_6_rounded,
                      title: 'App theme',
                      onTap: () => {},
                    ),
                    const ListDivider(),
                    const Padding(
                      padding: EdgeInsets.all(KSizes.md),
                      child: SectionHeading(label: 'Security'),
                    ),
                    SettingsListItem(
                      icon: Icons.fingerprint,
                      title: 'Screen lock',
                      onTap: () => {},
                    ),
                    const ListDivider(),
                    SettingsListItem(
                      icon: Icons.key,
                      title: 'Change password',
                      onTap: () => {},
                    ),
                    const ListDivider(),
                    SettingsListItem(
                      icon: Icons.star_rate_outlined,
                      title: 'Rate Trackpot',
                      onTap: () => {},
                    ),
                    const ListDivider(),
                    SettingsListItem(
                      icon: Icons.favorite_border,
                      title: 'Tell a friend',
                      onTap: () => {},
                    ),
                    const ListDivider(),
                    const Padding(
                      padding: EdgeInsets.all(KSizes.md),
                      child: SectionHeading(label: 'Trackpot'),
                    ),
                    SettingsListItem(
                      icon: Icons.info,
                      title: 'About us',
                      onTap: () => {},
                    ),
                    const ListDivider(),
                    SettingsListItem(
                      icon: Icons.star_rate_outlined,
                      title: 'Rate Trackpot',
                      onTap: () => {},
                    ),
                    const ListDivider(),
                    SettingsListItem(
                      icon: Icons.favorite_border,
                      title: 'Tell a friend',
                      onTap: () => {},
                    ),
                    const ListDivider(),
                    SettingsListItem(
                      icon: Icons.mail,
                      title: 'Trackpot Support',
                      onTap: () => {},
                    ),
                    const ListDivider(),
                    const SizedBox(
                      height: KSizes.sm,
                    ),
                    Center(
                        child: TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogOut());
                      },
                      child: Text(
                        'Log Out',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    )),
                    const SizedBox(
                      height: KSizes.md,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SafeArea(
            child: Center(
              child: Text('User not authenticated'),
            ),
          );
        }
      },
    );
  }
}
