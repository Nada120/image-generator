import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> widthAnimate;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    widthAnimate = Tween<double>(
      begin: 0,
      end: 200,
    ).animate(_controller);

    widthAnimate.addListener(() {
      setState(() {});
    });
    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, 'home');
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return buildUI(width, height);
  }

  Widget buildUI(double width, double height) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/ai_back.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 70),
          AnimatedContainer(
            curve: Curves.linear,
            padding: const EdgeInsets.symmetric(vertical: 5),
            duration: const Duration(milliseconds: 700),
            width: widthAnimate.value,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const Text(
              'Image Generator',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
