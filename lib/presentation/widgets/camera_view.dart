import 'package:flutter/material.dart';

/// Widget to display camera/gallery image preview
class CameraView extends StatelessWidget {
  final ImageProvider? image;

  const CameraView({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.width - 50,
      width: screenSize.height - 50,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        image: image != null
            ? DecorationImage(image: image!, fit: BoxFit.cover)
            : null,
      ),
      child: image == null ? const Center(child: Text("Image Preview")) : null,
    );
  }
}
