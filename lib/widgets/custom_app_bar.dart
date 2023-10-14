import 'package:flutter/material.dart';
import '../helper/colors.dart';

PreferredSizeWidget customAppBar() {
  return AppBar(
    backgroundColor: purpleBright,
    title: const Text(
      'AI IMAGE GENERATOR',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
  );
}
