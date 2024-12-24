import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _result;
  Uint8List? _imageBytes;

  // Function to predict the image
  Future<void> _predictImage() async {
    if (_image == null) {
      _showErrorDialog("Please select an image first");
      return;
    }
    final uri = Uri.parse("http://127.0.0.1:5000/predict");

    try {
      Uint8List imageBytes = await _image!.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'image': base64Image}));
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse['predictions'] != null) {
          setState(() {
            _result = decodedResponse['predictions']
                .map((pred) =>
                    "${pred['label']} (${(pred['confidence'] * 100).toStringAsFixed(2)}%)")
                .join("\n");
          });
        }
      } else {
        _showErrorDialog("Server error: ${response.body}");
      }
    } catch (e) {
      _showErrorDialog("Error connecting to server :$e");
    }
  }

  // Function to open the camera
  Future<void> _openCamera() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        Uint8List imageBytes = await pickedImage.readAsBytes();
        setState(() {
          _image = pickedImage;
          _imageBytes = imageBytes;
        });
        await _predictImage();
      }
    } catch (e) {
      _showErrorDialog('Error accessing the camera: $e');
    }
  }

  // Function to open the gallery
  Future<void> _openGallery() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        Uint8List imageBytes = await pickedImage.readAsBytes();
        setState(() {
          _image = pickedImage;
          _imageBytes = imageBytes;
        });
        await _predictImage();
      }
    } catch (e) {
      _showErrorDialog('Error accessing the gallery: $e');
    }
  }

  // Function to show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 208, 215, 232),
                    Color.fromARGB(255, 161, 180, 222)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Close button at the top right
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, size: 30, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              const Text(
                'Scan Your Fruit or Vegetable',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Image or default icon
              _imageBytes != null
                  ? Image.memory(
                      _imageBytes!,
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.camera_alt,
                      size: 100,
                      color: Colors.white.withOpacity(0.8),
                    ),
              const SizedBox(height: 20),
              // Buttons for accessing the camera and gallery
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _openCamera,
                    icon: const Icon(Icons.camera),
                    label: const Text('Use Camera'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _openGallery,
                    icon: const Icon(Icons.photo),
                    label: const Text('Upload from Gallery'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 248, 249, 250),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Prediction result
              if (_result != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Prediction Result:\n$_result',
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
