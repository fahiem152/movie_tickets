// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movie_tickets/presentation/msic/constans.dart';

class SelectableCardWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isEnable;
  final bool isSelected;
  const SelectableCardWidget({
    Key? key,
    required this.text,
    this.onTap,
    this.isEnable = true,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(
          10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            5,
          ),
          color: isSelected ? saffron.withOpacity(0.3) : null,
          border: Border.all(
            color: isEnable ? saffron : Colors.grey,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isEnable ? ghostWhite : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
