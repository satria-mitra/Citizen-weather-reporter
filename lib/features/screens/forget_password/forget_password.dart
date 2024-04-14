import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/common_widgets/form_header_widget.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/features/controllers/forget_password_controller.dart';

class ForgetPasswordMail extends StatelessWidget {
  const ForgetPasswordMail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            children: [
              const SizedBox(
                height: defaultSize,
              ),
              const FormHeaderWidget(
                crossAxisAlignment: CrossAxisAlignment.center,
                image: logInImage,
                title: forgetPassword,
                subTitle: forgetPasswordSubTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: formHeight - 16),
              Form(
                key: controller.forgetPasswordFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(email),
                        hintText: email,
                        prefixIcon: Icon(Icons.mail_outline_rounded),
                      ),
                    ),
                    const SizedBox(
                      height: formHeight - 8,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.sendPasswordResetEmail(),
                          child: const Text("Next"),
                        )),
                    const SizedBox(
                      height: formHeight - 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
