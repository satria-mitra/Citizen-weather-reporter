import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedMenu.value,
          onDestinationSelected: (index) =>
              controller.selectedMenu.value = index,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.map_outlined), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.analytics_outlined), label: 'Device'),
            NavigationDestination(
                icon: Icon(Icons.add_circle_outline), label: 'Add'),
            NavigationDestination(
                icon: Icon(Icons.add_chart_outlined), label: 'Data'),
            NavigationDestination(
                icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedMenu.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedMenu = 0.obs;
  final screens = [
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.black,
    ),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.yellow,
    )
  ];
}
