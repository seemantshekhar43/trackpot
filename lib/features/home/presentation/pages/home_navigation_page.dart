import 'package:flutter/material.dart';

class HomeNavigationPage extends StatelessWidget {
  final int pageIndex;
  final String pageAppBarTitle;
  final Widget? pageAbbBarIcon;
  final String navigationBarLabel;
  final Widget navigationBarIcon;
  final Widget page;
  const HomeNavigationPage(
      {super.key,
      required this.pageIndex,
      required this.pageAppBarTitle,
      this.pageAbbBarIcon,
      required this.navigationBarLabel,
      required this.navigationBarIcon, required this.page});

  @override
  Widget build(BuildContext context) {
    return page;
  }
}


