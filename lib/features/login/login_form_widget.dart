import 'package:flutter/material.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/constants/sizes.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline_outlined),
              labelText: email,
              hintText: email,
              border: OutlineInputBorder()),
        ),
        const SizedBox(height: formHeight - 20),
        TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.fingerprint),
            labelText: password,
            hintText: password,
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: null,
              icon: Icon(Icons.remove_red_eye_sharp),
            ),
          ),
        ),
        const SizedBox(height: formHeight - 20),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text(forgetPassword),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(login.toUpperCase()),
          ),
        )
      ],
    ));
  }
}
