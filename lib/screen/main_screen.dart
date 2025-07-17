import 'package:flutter/material.dart';
import 'package:crypto_app/shared/header.dart';
import 'package:crypto_app/shared/menu.dart';
import 'package:crypto_app/screen/follow.dart';
import 'package:crypto_app/screen/home.dart';
import 'package:crypto_app/screen/trade.dart';
import 'package:crypto_app/screen/account.dart';
import 'package:crypto_app/widgets/account_widgets/create_account.dart';

class MainScreen extends StatefulWidget {
  //final String uid;
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});
  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int selectedIndex = 0;
  final List<String> titles = [
    'Home',
    'Account',
    'Watch List',
    'Create Account',
    'Trade',
  ];
  final List<Widget> screens = [
    HomePage(),
    Account(),
    Follow(),
    CreateAccount(),
  ]; //, Trade()];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(title: titles[selectedIndex]),
      body: SafeArea(child: screens[selectedIndex]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Menu(
          selectedIndex: selectedIndex,
          onMenuTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
