import 'package:flutter/material.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/features/controllers/signup_controller.dart';
import 'package:get/get.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 16),
      child: Form(
        key: _formKey,
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
            TextFormField(
              controller: controller.password,

              decoration: const InputDecoration(
                label: Text(password),
                prefixIcon: Icon(Icons.fingerprint),
              ),
              // Add more FormFields or widgets here as needed
            ),
            const SizedBox(height: formHeight - 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SignUpController.instance.registerUser(
                        controller.email.text.trim(),
                        controller.password.text.trim());
                  }
                },
                child: Text(signUp.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
