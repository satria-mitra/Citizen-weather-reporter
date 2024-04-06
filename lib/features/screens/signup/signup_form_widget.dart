import 'package:flutter/material.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 16),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text(firstName),
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              // Add more FormFields or widgets here as needed
            ),
            const SizedBox(height: formHeight - 24),
            TextFormField(
              decoration: const InputDecoration(
                label: Text(lastName),
                prefixIcon: Icon(Icons.person_2_outlined),
              ),
              // Add more FormFields or widgets here as needed
            ),
            const SizedBox(height: formHeight - 24),
            TextFormField(
              decoration: const InputDecoration(
                label: Text(email),
                prefixIcon: Icon(Icons.email_outlined),
              ),
              // Add more FormFields or widgets here as needed
            ),
            const SizedBox(height: formHeight - 24),
            TextFormField(
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
                onPressed: () {},
                child: Text(signUp.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
