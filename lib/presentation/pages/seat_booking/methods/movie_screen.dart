import 'package:flutter/material.dart';
import 'package:movie_tickets/presentation/msic/constans.dart';

Widget movieScreen() => Container(
      height: 50,
      width: 250,
      margin: const EdgeInsets.only(top: 24, bottom: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [saffron.withOpacity(0.33), Colors.transparent],
          begin: Alignment.topCenter,
          end: AlignmentDirectional.bottomCenter,
        ),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 3,
          color: saffron,
        ),
      ),
    );
