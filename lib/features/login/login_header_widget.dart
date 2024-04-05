import 'package:flutter/material.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/constants/image_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Center(
          child: Image(
            image: const AssetImage(logInImage),
            height: size.height * 0.3,
          ),
        ),
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
