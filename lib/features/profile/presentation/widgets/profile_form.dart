import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/styles/sizes.dart';
import '../bloc/profile_bloc.dart';
import '../../../../core/widgets/currency_input_drop_down_field.dart';
import '../../../../core/widgets/input_text_field.dart';

class ProfileForm extends StatefulWidget {
  final User user;

  const ProfileForm(this.user, {super.key});

  @override
  ProfileFormState createState() => ProfileFormState();
}

class ProfileFormState extends State<ProfileForm> {
  late User _user;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  late TextEditingController _phoneNumberController;
  String _selectedCurrency = '';

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _firstNameController = TextEditingController(text: _user.firstName);
    _lastNameController = TextEditingController(text: _user.lastName ?? '');
    _usernameController = TextEditingController(text: _user.username);
    _phoneNumberController =
        TextEditingController(text: _user.phoneNumber ?? '');
    _selectedCurrency = _user.currency ?? '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _onChange(User changedUser) {
    context
        .read<ProfileBloc>()
        .add(ChangeProfileEvent(changedUser: changedUser));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: KSizes.circleImageAvatarRadiusSize,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                        width: KSizes.borderRadiusXSm,
                      ),
                    ),
                    padding: const EdgeInsets.all(KSizes.sm),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: KSizes.iconSm,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child:
                TextButton(onPressed: () {}, child: const Text('Edit Photo')),
          ),
          const SizedBox(height: KSizes.md),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: KSizes.md, vertical: KSizes.sm),
            child: InputTextField(
              labelText: 'First Name',
              controller: _firstNameController,
              onSaved: (value) {
                _user = _user.copyWith(firstName: value);
              },
              onChanged: (value) {
                _user = _user.copyWith(firstName: value);
                _onChange(_user);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: KSizes.md, vertical: KSizes.sm),
            child: InputTextField(
              labelText: 'Last Name',
              controller: _lastNameController,
              onSaved: (value) {
                _user = _user.copyWith(lastName: value);
              },
              onChanged: (value) {
                _user = _user.copyWith(lastName: value);
                _onChange(_user);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: KSizes.md, vertical: KSizes.sm),
            child: InputTextField(
              labelText: 'Username',
              controller: _usernameController,
              onSaved: (value) {
                _user = _user.copyWith(username: value);
              },
              onChanged: (value) {
                _user = _user.copyWith(username: value);
                _onChange(_user);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: KSizes.md, vertical: KSizes.sm),
            child: InputTextField(
              labelText: 'Phone Number',
              controller: _phoneNumberController,
              onSaved: (value) {
                _user = _user.copyWith(phoneNumber: value);
              },
              onChanged: (value) {
                _user = _user.copyWith(phoneNumber: value);
                _onChange(_user);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: KSizes.md, vertical: KSizes.sm),
            child: CurrencyInputDropDownField(
              labelText: 'Currency',
              value: _selectedCurrency,
              onChanged: (String? value) {
                setState(() {
                  _selectedCurrency = value ?? _selectedCurrency;
                });
                _user = _user.copyWith(currency: _selectedCurrency);
                _onChange(_user);
              },
            ),
          ),
        ],
      ),
    );
  }
}
