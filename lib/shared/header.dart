import 'package:flutter/material.dart';
import 'package:crypto_app/themes/ThemeSelector.dart';

class MyHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const ThemeSelectorDialog(),
          );
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: const [SizedBox(width: 48)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
