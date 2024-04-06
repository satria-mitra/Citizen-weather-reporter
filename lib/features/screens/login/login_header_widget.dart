import 'package:flutter/material.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/constants/image_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Center(
          child: Image(
            image: const AssetImage(logInImage),
            height: size.height * 0.3,
          ),
        ),
        const SizedBox(height: formHeight - 16),

        Text(
          loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: formHeight - 16),

        // Text(
        //   loginSubTitle,
        //   style: Theme.of(context).textTheme.headlineSmall,
        // ),
      ],
    );
  }
}
