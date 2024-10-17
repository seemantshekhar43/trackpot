import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackpot/features/account/pages/account_settings.dart';
import 'package:trackpot/features/home/presentation/pages/home_navigation_page.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<NavigationDestination> _navigationDestinations = [];

  final List<HomeNavigationPage> pages = [];

  @override
  void initState() {
    super.initState();
    HomeNavigationPage groupsPage = const HomeNavigationPage(
        pageIndex: 0,
        pageAbbBarIcon: Icon(Icons.notifications),
        pageAppBarTitle: 'Groups',
        navigationBarLabel: 'Groups',
        navigationBarIcon: Icon(Icons.group),
        page: AccountSettingsPage());
    HomeNavigationPage balancesPage = const HomeNavigationPage(
        pageIndex: 1,
        pageAppBarTitle: 'Balances',
        navigationBarLabel: 'Balances',
        navigationBarIcon: Icon(Icons.payment),
        page: AccountSettingsPage());
    HomeNavigationPage accountPage = const HomeNavigationPage(
        pageIndex: 2,
        pageAppBarTitle: 'Account',
        navigationBarLabel: 'Account',
        navigationBarIcon: Icon(Icons.account_circle),
        page: AccountSettingsPage());

    pages.add(groupsPage);
    pages.add(balancesPage);
    pages.add(accountPage);

    _navigationDestinations.addAll(pages.map((page) {
      return NavigationDestination(
        icon: page.navigationBarIcon,
        label: page.navigationBarLabel,
      );
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pages[state.index].pageAppBarTitle,
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                if (pages[state.index].pageAbbBarIcon != null)
                  pages[state.index].pageAbbBarIcon!
              ],
            ),

            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
          ),
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
