import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
      destinations: [
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.black,
        ),
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.red,
        ),
      ],
    ));
  }
}
