import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  ImagePickerPageState createState() => ImagePickerPageState();
}

class ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePickerService _imagePickerService = ImagePickerService();
  List<XFile>? _selectedImages = [];
  XFile? _capturedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Button to pick multiple images from gallery
            ElevatedButton(
              onPressed: () async {
                List<XFile> images =
                    await _imagePickerService.pickImagesFromGallery();
                setState(() {
                  _selectedImages = images;
                });
              },
              child: const Text('Pick Images from Gallery'),
            ),
            // Display selected images
            _selectedImages?.isNotEmpty ?? false
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _selectedImages?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Image.file(File(_selectedImages![index].path));
                      },
                    ),
                  )
                : Container(),
            // Button to pick a single image from the camera
            ElevatedButton(
              onPressed: () async {
                XFile? image = await _imagePickerService.pickImageFromCamera();
                setState(() {
                  _capturedImage = image;
                });
              },
              child: const Text('Capture Image from Camera'),
            ),
            // Display captured image
            _capturedImage != null
                ? Image.file(File(_capturedImage!.path))
                : Container(),
          ],
        ),
      ),
    );
  }
}
