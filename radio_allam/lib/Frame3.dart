import 'package:flutter/material.dart';

class Frame3 extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;
  final String imagePath;

  const Frame3({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        width: double.infinity,
        height: 96,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Your existing Frame3 widget code
          ],
        ),
      ),
    );
  }
}