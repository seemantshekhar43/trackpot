import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../init_dependencies.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/profile_form.dart';

class ProfilePage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => ProfilePage(),
      );
  ProfilePage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, appUserState) {
        if (appUserState is AppUserAuthenticated) {
          final user = appUserState.user;
          return BlocProvider(
            create: (_) => serviceLocator<ProfileBloc>(param1: user),
            child: Form(
              key: _formKey,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Edit Profile',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  centerTitle: true,
                  actions: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileSaving) {
                          return const Padding(
                            padding: EdgeInsets.only(right: KSizes.md),
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return BlocSelector<ProfileBloc, ProfileState, bool>(
                            selector: (state) => state is ProfileChanged,
                            builder: (context, isEnabled) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: KSizes.md),
                                child: TextButton(
                                  onPressed: isEnabled
                                      ? () => _saveProfile(context)
                                      : null,
                                  child: Text(
                                    'Save',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: isEnabled
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Theme.of(context).disabledColor,
                                        ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
                body: BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                    if (state is ProfileSaved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Profile updated successfully!')),
                      );
                    }
                  },
                  child: ProfileForm(user),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('User not authenticated'),
            ),
          );
        }
      },
    );
  }

  void _saveProfile(BuildContext context) {
    final form = Form.of(context);
    if (form.validate()) {
      form.save();
      context.read<ProfileBloc>().add(SaveProfileEvent());
    }
  }
}
