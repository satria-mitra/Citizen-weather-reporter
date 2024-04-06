import 'package:flutter/material.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/text_string.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    required this.image,
    required this.title,
  });

  final String image, title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Image(
          image: const AssetImage(signUpImage),
          height: size.height * 0.2,
        ),
        const SizedBox(height: 16),

        Text(
          signUpTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        // const SizedBox(height: formHeight - 16),
        // Text(
        //   loginSubTitle,
        //   style: Theme.of(context).textTheme.headlineSmall,
        // ),
      ],
    );
  }
}
