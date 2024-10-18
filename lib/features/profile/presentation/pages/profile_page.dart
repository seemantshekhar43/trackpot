import 'package:flutter/material.dart';
import 'package:trackpot/core/constants/profile_constants.dart';
import '../widgets/profile_input_drop_down_field.dart';

import '../../../../core/styles/sizes.dart';
import '../widgets/profile_input_text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      );

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String updatedValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit profile',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: KSizes.md),
            child: Text(
              'Save',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Stack(alignment: Alignment.bottomRight, children: [
                const CircleAvatar(
                  radius: KSizes.circleImageAvatarRadiusSize,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                Positioned(

                  child: Container(
                    decoration: BoxDecoration(
                      color:
                      Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:  Theme.of(context).colorScheme.surface,
                        width: KSizes.borderRadiusXSm,
                      ),
                    ),
                    padding: const EdgeInsets.all(
                        KSizes.sm), // Adjust padding for the icon
                    child: const Icon(
                      Icons.edit, // Edit icon
                      color: Colors.white, // Icon color
                      size: KSizes.iconSm, // Icon size
                    ),
                  ),
                ),
              ]),
            ),
            Center(
              child:
                  TextButton(onPressed: () {}, child: const Text('Edit Photo')),
            ),
            const SizedBox(
              height: KSizes.md,
            ),
            ProfileInputTextField(
              labelText: 'First Name',
              controller: firstNameController,
            ),
            ProfileInputTextField(
              labelText: 'Last Name',
              controller: lastNameController,
            ),
            ProfileInputTextField(
              labelText: 'Username',
              controller: usernameController,
            ),
            ProfileInputTextField(
              labelText: 'Phone Number',
              controller: phoneNumberController,
            ),
            ProfileInputDropDownField(
              labelText: 'Currency',
              onChanged: (String? value) {
                updatedValue = value ?? updatedValue;
              },
              items: ProfileConstants.currencyMap,
            )
          ],
        ),
      ),
    );
  }
}
