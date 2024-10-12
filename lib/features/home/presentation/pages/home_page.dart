import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.group),
      label: 'Groups',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.payment),
      label: 'Balances',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: 'Account',
    ),
  ];
  final List<Widget> pages = const [
    Text('Index 0: Groups'),
    Text('Index 1: Balances'),
    Text('Index 2: Account'),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(child: pages.elementAt(state.index)),
          bottomNavigationBar: BottomNavigationBar(
            items: items,
            currentIndex: state.index,
            onTap: (index) =>
                context.read<HomeBloc>().add(PageChangeEvent(index)),
          ),
        );
      },
    );
  }
}
