import 'package:flutter/material.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: const AssetImage(logInImage),
                height: size.height * 0.3,
              ),
              Text(
                loginTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                loginSubTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_outlined),
                        labelText: email,
                        hintText: email,
                        border: OutlineInputBorder()),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
