import 'package:flutter/material.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/features/screens/login/login_form_widget.dart';
import 'package:weathershare/features/screens/login/login_header_widget.dart';
import 'package:weathershare/features/screens/login/login_footer_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [LoginHeaderWidget(), LoginForm(), LoginFooterWidget()],
          ),
        ),
      ),
    );
  }
}
