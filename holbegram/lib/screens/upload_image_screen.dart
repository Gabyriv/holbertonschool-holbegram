import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Screen for adding a profile picture during sign up.
class AddPicture extends StatefulWidget {
  // User email passed from the previous screen.
  final String email;
  // User password passed from the previous screen.
  final String password;
  // User username passed from the previous screen.
  final String username;

  const AddPicture({
    super.key,
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  // Holds the selected image bytes.
  Uint8List? _image;

  // Select an image from the gallery and store it in memory.
  void selectImageFromGallery() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      return;
    }

    final Uint8List imageBytes = await pickedImage.readAsBytes();

    setState(() {
      _image = imageBytes;
    });
  }

  // Select an image from the camera and store it in memory.
  void selectImageFromCamera() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage == null) {
      return;
    }

    final Uint8List imageBytes = await pickedImage.readAsBytes();

    setState(() {
      _image = imageBytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 64,
              backgroundImage: _image != null
                  ? MemoryImage(_image!)
                  : const AssetImage('assets/images/Sample_User_Icon.png')
                      as ImageProvider,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_camera),
                  onPressed: selectImageFromCamera,
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.photo_library),
                  onPressed: selectImageFromGallery,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
