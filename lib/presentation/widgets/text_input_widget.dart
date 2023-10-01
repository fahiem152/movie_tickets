import 'package:flutter/material.dart';
import 'package:movie_tickets/presentation/msic/constans.dart';

class TextInpuWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  const TextInpuWidget({
    Key? key,
    required this.controller,
    this.obscureText = false,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: ghostWhite),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade800,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ghostWhite,
          ),
        ),
      ),
    );
  }
}
