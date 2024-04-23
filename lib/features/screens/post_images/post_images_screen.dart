import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostImagesScreen extends StatefulWidget {
  const PostImagesScreen({super.key});

  @override
  State<PostImagesScreen> createState() => _PostImagesScreenState();
}

class _PostImagesScreenState extends State<PostImagesScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  File? _image;
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller?.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            if (_controller != null)
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      height: 300, // Set a height for the camera preview
                      child: CameraPreview(_controller!),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            const SizedBox(height: 20),
            _image != null ? Image.file(_image!) : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _takePicture,
                  child: const Text("Capture Image"),
                ),
                ElevatedButton(
                  onPressed: _loadImageFromGallery,
                  child: const Text("Pick from Gallery"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      final image = await _controller!.takePicture();
      if (!mounted) return;

      setState(() {
        _image = File(image.path);
      });
    } catch (e) {
      //print("Error taking picture: $e");
    }
  }

  Future<void> _loadImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      //print("Error picking image from gallery: $e");
    }
  }
}
