import 'package:flutter/material.dart';
import 'package:flutter_foodycam/core/constants.dart';

class CameraView extends StatelessWidget {
  final ImageProvider? image;

  const CameraView({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: screenSize.height / 2,
        width: screenSize.width - 50,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? colorSchemeLight.primaryContainer
              : colorSchemeDark.primary,
          borderRadius: BorderRadius.circular(12),
          image: image != null
              ? DecorationImage(image: image!, fit: BoxFit.cover)
              : null,
        ),
        child: image == null
            ? const Center(
                child: Text(
                  "Capture a photo /\n Select one from gallery\n to preview here!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              )
            : null,
      ),
    );
  }
}
