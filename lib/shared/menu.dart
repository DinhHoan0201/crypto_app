import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final Function(int) onMenuTap;
  final int selectedIndex;
  Menu({super.key, required this.selectedIndex, required this.onMenuTap});

  final List<IconData> menuIcons = [
    Icons.home,
    Icons.account_circle,
    Icons.trending_up,
    Icons.compare_arrows,
  ];

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuIcons.length, (index) {
        final isSelected = index == selectedIndex;
        return GestureDetector(
          onTap: () => onMenuTap(index),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Icon(
              menuIcons[index],
              color:
                  isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[300],
              size: 30,
            ),
          ),
        );
      }),
    );
  }
}
