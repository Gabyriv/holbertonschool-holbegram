import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/home.dart';
import 'package:holbegram/screens/pages/methods/post_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// Add image page for creating a new post.
class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  // Holds the selected image bytes.
  Uint8List? _image;
  // Controller for the post caption input.
  final TextEditingController _captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Refresh user data so we can use it when posting.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).refreshUser();
    });
  }

  @override
  void dispose() {
    // Dispose the caption controller when the widget is removed.
    _captionController.dispose();
    super.dispose();
  }

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
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder icon that swaps to the selected image.
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: _image != null
                      ? MemoryImage(_image!)
                      : const AssetImage('assets/images/add-2935429_960_720.jpg')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Caption input for the post.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _captionController,
                decoration: const InputDecoration(
                  hintText: 'Write a caption...',
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Camera and gallery actions.
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
            const SizedBox(height: 16),
            // Post action button.
            SizedBox(
              height: 48,
              width: 160,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(218, 226, 37, 24),
                  ),
                ),
                onPressed: () async {
                  if (_image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select an image')),
                    );
                    return;
                  }

                  final String result = await PostStorage().uploadPost(
                    _captionController.text,
                    userProvider.user.uid,
                    userProvider.user.username,
                    userProvider.user.photoUrl,
                    _image!,
                  );

                  if (!mounted) {
                    return;
                  }

                  if (result == 'Ok') {
                    // Navigate back to the home page after posting.
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result)),
                    );
                  }
                },
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
