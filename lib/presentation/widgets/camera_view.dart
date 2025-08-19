import 'package:flutter/material.dart';

/// Widget to display camera/gallery image preview
class CameraView extends StatelessWidget {
  final ImageProvider? image;

  const CameraView({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        image: image != null
            ? DecorationImage(image: image!, fit: BoxFit.cover)
            : null,
      ),
      child: image == null
          ? const Center(child: Text("Image Preview"))
          : null,
    );
  }
}
