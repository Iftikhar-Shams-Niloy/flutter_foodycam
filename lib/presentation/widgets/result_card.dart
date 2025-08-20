import 'package:flutter/material.dart';
import '../../core/constants.dart';

class ResultCard extends StatelessWidget {
  final String label;
  final double confidence;

  const ResultCard({super.key, required this.label, required this.confidence});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width - 50,
      child: Card(
        color: Colors.indigo.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: customPurple,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Confidence: ${(confidence * 100).toStringAsFixed(2)}%",
                style: const TextStyle(
                  fontSize: 16,
                  color: customPurple,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
