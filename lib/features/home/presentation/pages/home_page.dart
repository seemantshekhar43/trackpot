import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../account/pages/account_settings.dart';
import '../../../groups/presentation/pages/groups_page.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<NavigationDestination> _navigationDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.group),
      label: 'Groups',
    ),
    NavigationDestination(
      icon: Icon(Icons.payment),
      label: 'Balance',
    ),
    NavigationDestination(
      icon: Icon(Icons.account_circle),
      label: 'Account',
    ),
  ];

  final List<Widget> pages = const [
    GroupsPage(),
    AccountSettingsPage(),
    AccountSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: pages[state.index],
          bottomNavigationBar: NavigationBar(
            destinations: _navigationDestinations,
            selectedIndex: state.index,
            onDestinationSelected: (index) =>
                context.read<HomeBloc>().add(PageChangeEvent(index)),
          ),
        );
      },
    );
  }
}
