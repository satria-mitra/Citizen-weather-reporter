import 'package:flutter/material.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/features/controllers/login_controller.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:get/get.dart';
import 'package:weathershare/features/screens/forget_password/forget_password.dart';
import 'package:weathershare/features/screens/signup/signup_screen.dart';

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

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller.email,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline_outlined),
              labelText: email,
              hintText: email,
              border: OutlineInputBorder()),
        ),
        const SizedBox(height: formHeight - 10),
        Obx(
          () => TextFormField(
            obscureText: controller.hidePassword.value,
            controller: controller.password,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.fingerprint),
              labelText: password,
              hintText: password,
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () => controller.hidePassword.value =
                    !controller.hidePassword.value,
                icon: const Icon(Icons.remove_red_eye_sharp),
              ),
            ),
          ),
        ),
        const SizedBox(height: formHeight - 16),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Get.to(() => const ForgetPasswordMail()),
            child: const Text(forgetPassword),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.emailAndPasswordSignIn(),
            child: Text(login.toUpperCase()),
          ),
        ),
        const SizedBox(height: formHeight - 16),
      ],
    ));
  }
}

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: formHeight - 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => controller.googleSignIn(),
            label: const Text(signInWithGoogle),
            icon: const Image(
              image: AssetImage(googleLogo),
              width: 24.0,
            ),
          ),
        ),
        const SizedBox(height: formHeight - 16),
        TextButton(
          onPressed: () => Get.to(() => const SignUpScreen()),
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
