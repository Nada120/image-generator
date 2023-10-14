import 'package:flutter/material.dart';
import '../helper/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? textController;
  final void Function(String)? onFieldSubmitted;
  const CustomTextField({
    super.key, 
    required this.textController,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        controller: textController,
        cursorColor: purpleBright2,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: black,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: purpleBright2,
            ),
          ),
          hintText: 'Describe The Image',
          hintStyle: TextStyle(
            color: blackBright2,
          ),
        ),
      ),
    );
  }
}
