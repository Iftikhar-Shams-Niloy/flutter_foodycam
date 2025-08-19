import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.iconSize,
    this.fontSize,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  final double? iconSize;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final double defaultIconSize = MediaQuery.of(context).size.width * 0.1;
    final double defaultFontSize = MediaQuery.of(context).size.width * 0.035;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        onPressed: onPressed, // Fixed: removed the arrow function
        style: ElevatedButton.styleFrom(
          elevation: 8,
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon, // Use the passed icon
              size: iconSize ?? defaultIconSize,
            ),
            const SizedBox(height: 8),
            Text(
              text, // Use the passed text
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize ?? defaultFontSize),
            ),
          ],
        ),
      ),
    );
  }
}
