import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
  final ImageProvider? image;

  const CameraView({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Material(
      elevation: 8,
      shadowColor: Colors.deepPurple,
      child: Container(
        height: screenSize.height / 2,
        width: screenSize.width - 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.indigo.shade100, width: 10.0),
          image: image != null
              ? DecorationImage(image: image!, fit: BoxFit.cover)
              : null,
        ),
        child: image == null ? const Center(child: Text("Image Preview")) : null,
      ),
    );
  }
}
