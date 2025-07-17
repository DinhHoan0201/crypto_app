import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final Function(int) onCategoryTap;
  int selectedIndex;
  CategorySelector({
    super.key,
    required this.selectedIndex,
    required this.onCategoryTap,
  });
  @override
  final List<String> categories = ['All', 'SP500', 'Forex', 'Crypto', 'Stock'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(categories.length, (index) {
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () => onCategoryTap(index),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
