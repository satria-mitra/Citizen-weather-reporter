import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              otpTitle.toUpperCase(),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              otpSubTitle,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              height: 16,
            ),
            OtpTextField(
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code) {
                print("OTP is => $code");
              },
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(next),
                )),
          ],
        ),
      ),
    );
  }
}
