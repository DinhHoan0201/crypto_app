import 'package:flutter/material.dart';
import 'package:crypto_app/model/iconbt_model.dart';

class Functionbutton extends StatefulWidget {
  const Functionbutton({super.key});
  State<Functionbutton> createState() => _Functionbutton();
}

class _Functionbutton extends State<Functionbutton> {
  final List<ActionItem> actions = [
    ActionItem(
      icon: Icons.arrow_downward,
      label: 'Buy',
      onTap: () => print('Buy'),
    ),
    ActionItem(
      icon: Icons.arrow_upward,
      label: 'Sell',
      onTap: () => print('Sell'),
    ),
    ActionItem(
      icon: Icons.swap_horiz,
      label: 'Swap',
      onTap: () => print('Swap'),
    ),
    ActionItem(
      icon: Icons.settings,
      label: 'Setting',
      onTap: () => print('Setting'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:
          actions.map((item) {
            return GestureDetector(
              onTap: item.onTap,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(14),
                    child: Icon(item.icon, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.label,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
