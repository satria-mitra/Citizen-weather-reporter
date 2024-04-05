import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/features/login/login_form_widget.dart';
import 'package:weathershare/features/login/login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginHeaderWidget(size: size),
              const LoginForm(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("OR"),
                  const SizedBox(height: formHeight - 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      label: const Text(signInWithGoogle),
                      icon: const Image(
                        image: AssetImage(googleLogo),
                        width: 25.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: formHeight - 16),
                  TextButton(
                    onPressed: () {},
                    child: const Text(alreadyHaveAnAccount),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
