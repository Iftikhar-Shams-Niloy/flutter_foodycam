import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_foodycam/presentation/widgets/custom_elevated_buttons.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model_loader.dart';
import '../../data/image_processor.dart';
import '../../data/prediction_service.dart';
import '../../domain/prediction.dart';
import '../widgets/camera_view.dart';
import '../widgets/result_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  File? _selectedImage;
  Prediction? _prediction;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();
  late final ModelLoader _modelLoader;
  late final PredictionService _predictionService;

  @override
  void initState() {
    super.initState();
    _modelLoader = ModelLoader();
    _predictionService = PredictionService(_modelLoader, ImageProcessor());

    _initModel();
  }

  Future<void> _initModel() async {
    await _modelLoader.loadModel();
  }

  Future<void> _classifyImage(File imageFile) async {
    setState(() {
      _isLoading = true;
      _prediction = null; // Reset previous prediction
      _selectedImage = imageFile;
    });

    final prediction = await _predictionService.predict(imageFile);

    if (mounted) {
      setState(() {
        _prediction = prediction;
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _selectedImage = file;
      });
      _classifyImage(file);
    }
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _selectedImage = file;
      });
      _classifyImage(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FoodyCam",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CameraView(
              image: _selectedImage != null ? FileImage(_selectedImage!) : null,
            ),
            const SizedBox(height: 12),

            _isLoading
                ? const CircularProgressIndicator()
                : _prediction != null
                ? ResultCard(
                    label: _prediction!.label,
                    confidence: _prediction!.confidence,
                  )
                : const Text(
                    "Food Classification",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  onPressed: _pickImageFromCamera,
                  icon: Icons.camera_alt,
                  text: "Capture\nFood Image",
                ),

                CustomElevatedButton(
                  onPressed: _pickImageFromGallery,
                  icon: Icons.photo_library,
                  text: "Select\nFrom Gallery",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
