import 'package:flutter/material.dart';

Widget transactionRow({
  required String title,
  required String value,
}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Text(value),
          )
        ],
      ),
    );
