import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/common_widgets/form_header_widget.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/features/controllers/login_controller.dart';
import 'package:weathershare/features/controllers/signup_controller.dart';
import 'package:weathershare/features/screens/login/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

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
                        onPressed: () => controller.googleSignIn(),
                        icon: const Image(
                          image: AssetImage(googleLogo),
                          width: 16,
                        ),
                        label: const Text(signInWithGoogle)),
                  ),
                  TextButton(
                      onPressed: () => Get.to(() => const LoginScreen()),
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

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 16),
      child: Form(
        key: controller.signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.firstName,
              decoration: const InputDecoration(
                label: Text(firstName),
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              // Add more FormFields or widgets here as needed
            ),
            const SizedBox(height: formHeight - 24),
            TextFormField(
              controller: controller.lastName,
              decoration: const InputDecoration(
                label: Text(lastName),
                prefixIcon: Icon(Icons.person_2_outlined),
              ),
              // Add more FormFields or widgets here as needed
            ),
            const SizedBox(height: formHeight - 24),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                label: Text(email),
                prefixIcon: Icon(Icons.email_outlined),
              ),
              // Add more FormFields or widgets here as needed
            ),
            const SizedBox(height: formHeight - 24),
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  label: const Text(password),
                  prefixIcon: const Icon(Icons.fingerprint),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: const Icon(Icons.visibility_outlined),
                  ),
                  // Add more FormFields or widgets here as needed
                ),
              ),
            ),
            const SizedBox(height: formHeight - 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: Text(signUp.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
