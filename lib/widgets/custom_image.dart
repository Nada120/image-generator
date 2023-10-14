import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final double size;
  final String imagePath;
  final Animation<double>? animation;

  const CustomImage({
    super.key,
    required this.size,
    required this.imagePath,
    this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: size,
      height: size,
      fit: BoxFit.fill,
      opacity: animation,
    );
  }
}
