import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/text_string.dart';
//import 'package:weathershare/features/controllers/forget_password_controller.dart';

class ForgetPasswordMail extends StatelessWidget {
  const ForgetPasswordMail({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(ForgetPasswordController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const FormHeaderWidget(
                crossAxisAlignment: CrossAxisAlignment.center,
                image: logInImage,
                title: forgetPassword,
                subTitle: forgetPasswordSubTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Form(
                //key: controller.forgetPasswordFormKey,
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
                      height: 24,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Next"),
                        )),
                    const SizedBox(
                      height: 24,
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
