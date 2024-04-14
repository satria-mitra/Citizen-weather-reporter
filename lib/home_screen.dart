import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
      destinations: const [
        NavigationDestination(icon: Icon(Icons.map_outlined), label: 'Home'),
        NavigationDestination(
            icon: Icon(Icons.analytics_outlined), label: 'Home'),
        NavigationDestination(
            icon: Icon(Icons.add_circle_outline), label: 'Home'),
        NavigationDestination(
            icon: Icon(Icons.add_chart_outlined), label: 'Home'),
        NavigationDestination(
            icon: Icon(Icons.account_circle_outlined), label: 'Home'),
      ],
    ));
  }
}
