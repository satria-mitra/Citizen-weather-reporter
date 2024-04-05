import 'package:flutter/material.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/constants/image_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Text.rich(
            TextSpan(
                text: dontHaveAccount,
                style: Theme.of(context).textTheme.bodyMedium,
                children: const [
                  TextSpan(
                    text: signUp,
                    style: TextStyle(color: Colors.lightBlue),
                  )
                ]),
          ),
        ),
      ],
    );
  }
}
