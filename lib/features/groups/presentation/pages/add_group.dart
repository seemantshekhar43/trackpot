import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../core/widgets/camera_bottom_sheet.dart';
import '../../../../core/widgets/currency_input_drop_down_field.dart';
import '../../../../core/widgets/input_text_field.dart';
import '../../../../core/styles/sizes.dart';
import '../widgets/category_horizontal_list.dart';

class AddGroupPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddGroupPage(),
      );
  const AddGroupPage({super.key});

  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  String? _selectedCategory;
  String? _selectedCurrency;
  final TextEditingController _nameController = TextEditingController();

  final List<String> currencies = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'AUD',
    'CAD',
    'INR'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Group'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            left: KSizes.md,
            right: KSizes.md,
            top: KSizes.smd,
            bottom: KSizes.lg),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Add your create group logic here
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Create',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(KSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Group Photo Section
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showPhotoSelectionBottomSheet(context);
                        },
                        child: Container(
                          width: KSizes.containerSquareSMd,
                          height: KSizes.containerSquareSMd,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onInverseSurface
                                  .withOpacity(0.9),
                              borderRadius: BorderRadius.circular(KSizes.smd)),
                          child: _imageFile != null
                              ? ClipOval(
                                  child: Image.file(
                                    _imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.camera_alt_outlined,
                                  size: KSizes.iconLg,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                        ),
                      ),
                      const SizedBox(height: KSizes.sm),
                      Text('Tap to add group photo',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.color
                                      ?.withOpacity(0.8))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: KSizes.lg,
                ),

                // Group Name Field
                InputTextField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a group name';
                    }
                    return null;
                  },
                  labelText: 'Group Name',
                ),
                const SizedBox(height: KSizes.md),

                // Currency Dropdown
                CurrencyInputDropDownField(
                  labelText: 'Currency',
                  value: _selectedCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCurrency = newValue;
                    });
                  },
                ),
                const SizedBox(height: KSizes.md),

                // Category Section
                Text(
                  'Group Category',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: KSizes.sm),
                CategoryHorizontalList(
                  selectedCategory: _selectedCategory,
                  onSelect: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),

                // Create Button

                //const SizedBox(height: KSizes.md)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}