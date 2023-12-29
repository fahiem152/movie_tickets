import 'package:flutter/material.dart';
import 'package:movie_tickets/presentation/widgets/seat_widget.dart';

Widget legend() => const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SeatWidget(
          size: 20,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          "Available",
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        SeatWidget(
          size: 20,
          status: SeatStatus.selceted,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          "Selected",
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        SeatWidget(
          size: 20,
          status: SeatStatus.reserved,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          "Reserved",
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
      ],
    );
