import 'package:flutter/material.dart';
import 'package:movie_tickets/presentation/widgets/bottom_nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  final List<BottomNavBarItem> items;
  final void Function(int index) onTap;
  final int selectedIndex;
  const BottomNavBar({
    Key? key,
    required this.items,
    required this.onTap,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        decoration: BoxDecoration(
          color: const Color.fromARGB(200, 12, 12, 17),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              20,
            ),
            topRight: Radius.circular(
              20,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items
              .map((e) => GestureDetector(
                    onTap: () => onTap(e.index),
                    child: e,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
