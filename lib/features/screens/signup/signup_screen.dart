import 'package:flutter/material.dart';
import 'package:weathershare/common_widgets/form_header_widget.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/constants/image_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          label: Text(fullName),
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                        // Add more FormFields or widgets here as needed
                      ),
                      const SizedBox(height: formHeight - 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text(userName),
                          prefixIcon:
                              Icon(Icons.supervised_user_circle_outlined),
                        ),
                        // Add more FormFields or widgets here as needed
                      ),
                      const SizedBox(height: formHeight - 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text(email),
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        // Add more FormFields or widgets here as needed
                      ),
                      const SizedBox(height: formHeight - 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text(password),
                          prefixIcon: Icon(Icons.fingerprint),
                        ),
                        // Add more FormFields or widgets here as needed
                      ),
                      const SizedBox(height: formHeight - 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(signUp.toUpperCase()),
                        ),
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
