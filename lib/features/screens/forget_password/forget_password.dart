import 'package:flutter/material.dart';
import 'package:weathershare/common_widgets/form_header_widget.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';

class ForgetPasswordMail extends StatelessWidget {
  const ForgetPasswordMail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: const Column(
          children: [
            SizedBox(
              height: defaultSize * 4,
            ),
          ],
        ),
      ),
    );
  }
}
