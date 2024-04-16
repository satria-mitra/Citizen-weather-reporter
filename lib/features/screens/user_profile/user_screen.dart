import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(image: AssetImage(userProfilePicture)),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => Text(
                  controller.user.value.firstname,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Text(
                controller.user.value.email,
                style: Theme.of(context).textTheme.bodyLarge,
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
