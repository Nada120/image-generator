import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final void Function()? onTap;
  final List<Color> colors;
  final double rightMargin;

  const CustomButton({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    this.onTap,
    required this.colors,
    this.rightMargin = 15,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: rightMargin),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: colors,
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
