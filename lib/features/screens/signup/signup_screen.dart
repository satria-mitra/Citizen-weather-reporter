import 'package:flutter/material.dart';
import 'package:weathershare/common_widgets/form_header_widget.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/features/screens/signup/signup_form_widget.dart';
import 'package:weathershare/constants/text_string.dart';

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
                crossAxisAlignment: CrossAxisAlignment.center,
                image:
                    signUpImage, // Ensure this is the correct variable for the image path
                title: signUpTitle,
                subTitle:
                    welcomeTitle, // Ensure this is the correct variable for the title
              ),
              const SignUpFormWidget(),
              Column(
                children: [
                  const Text("OR"),
                  const SizedBox(height: formHeight - 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Image(
                          image: AssetImage(googleLogo),
                          width: 16,
                        ),
                        label: const Text(signInWithGoogle)),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: alreadyHaveAnAccount,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const TextSpan(text: login),
                      ])))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
