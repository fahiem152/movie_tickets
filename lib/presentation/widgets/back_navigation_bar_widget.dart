// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:movie_tickets/presentation/msic/methods.dart';

class BackNavigationBarWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const BackNavigationBarWidget({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 40,
            width: 40,
            child: Image.asset(
              'assets/back.png',
            ),
          ),
        ),
        horizontalSpace(20),
        SizedBox(
          width: MediaQuery.of(context).size.width - 60 - 48,
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
