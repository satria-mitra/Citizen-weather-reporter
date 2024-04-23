import 'package:flutter/material.dart';

class PostImagesScreen extends StatefulWidget {
  const PostImagesScreen({super.key});

  @override
  State<PostImagesScreen> createState() => _PostImagesScreenState();
}

class _PostImagesScreenState extends State<PostImagesScreen> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF272727) : const Color(0xffffffff),
      appBar: AppBar(
        title: const Text("New Post"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
    );
  }
}
