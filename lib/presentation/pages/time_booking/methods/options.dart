import 'package:flutter/material.dart';
import 'package:movie_tickets/presentation/widgets/selectable_card_widget.dart';

List<Widget> options<T>({
  required String title,
  required List<T> options,
  required T? selectedItem,
  String Function(T object)? coverter,
  bool Function(T object)? isOptionEnable,
  required void Function(T object) onTap,
}) =>
    [
      Padding(
        padding: EdgeInsets.only(
          left: 24,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: options
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.only(
                      left: e == options.first ? 24 : 0,
                      right: e == options.last ? 24 : 10,
                    ),
                    child: SelectableCardWidget(
                      text: coverter != null ? coverter(e) : e.toString(),
                      isSelected: e == selectedItem,
                      isEnable: isOptionEnable?.call(e) ?? true,
                      onTap: () => onTap(e),
                    ),
                  ),
                )
                .toList()),
      )
    ];
