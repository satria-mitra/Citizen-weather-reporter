import 'package:flutter/material.dart';
import 'package:weathershare/common_widgets/form_header_widget.dart';
import 'package:weathershare/constants/colors.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/constants/image_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? secondaryColor : primaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            children: [
              const FormHeaderWidget(
                image:
                    signUpImage, // Ensure this is the correct variable for the image path
                title:
                    signUpTitle, // Ensure this is the correct variable for the title
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: formHeight - 8),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          label: const Text(
                            fullName,
                          ),
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: accentColor,
                          ),
                          labelStyle: TextStyle(
                            color: isDarkMode ? primaryColor : secondaryColor,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: accentColor,
                            ),
                          ),
                        ),
                        // Add more FormFields or widgets here as needed
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
