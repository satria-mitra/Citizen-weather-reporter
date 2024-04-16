import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:weathershare/constants/colors.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/features/controllers/user_controller.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    //print("name is ");
    //print(controller.user.value.firstname);

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? secondaryColor : primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false, // No back button

        title: Text(
          userProfile,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center horizontally

            children: [
              Obx(
                () => SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: controller.user.value.profilePicture.isNotEmpty
                        ? Image.network(
                            controller.user.value.profilePicture,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.account_circle, size: 120),
                          )
                        : const Icon(Icons.account_circle,
                            size: 120), // Fallback icon
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => Text(
                  controller.user.value.firstname,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Obx(
                () => Text(
                  controller.user.value.email,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "Manage xx IoT Devices",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => controller.logout(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(
                    logOutText,
                    style: TextStyle(color: darkColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
