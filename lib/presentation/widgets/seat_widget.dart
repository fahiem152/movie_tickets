// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movie_tickets/presentation/msic/constans.dart';

enum SeatStatus {
  available,
  selceted,
  reserved,
}

class SeatWidget extends StatelessWidget {
  final int? number;
  final SeatStatus status;
  final double size;
  final VoidCallback? onTap;
  const SeatWidget({
    Key? key,
    this.number,
    this.status = SeatStatus.available,
    this.size = 30,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: status == SeatStatus.available
                ? Colors.white
                : status == SeatStatus.reserved
                    ? Colors.grey
                    : saffron,
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          child: Center(
            child: Text(
              number?.toString() ?? '',
              style: const TextStyle(
                color: backgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
