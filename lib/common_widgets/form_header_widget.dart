import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.imageHeight = 0.3,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final double imageHeight;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        const SizedBox(height: 32),
        Image(
          image: AssetImage(image),
          height: size.height * imageHeight,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: textAlign,
        ),
        const SizedBox(height: 8),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: textAlign,
        ),
      ],
    );
  }
}
