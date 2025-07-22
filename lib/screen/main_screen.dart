import 'package:crypto_app/model/coinlist_model.dart';
import 'package:crypto_app/providers/selected_coin_provider.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/shared/header.dart';
import 'package:crypto_app/shared/menu.dart';
import 'package:crypto_app/screen/follow.dart';
import 'package:crypto_app/screen/home.dart';
import 'package:crypto_app/screen/trade.dart';
import 'package:crypto_app/screen/account.dart';
import 'package:crypto_app/widgets/account_widgets/create_account.dart';
import 'package:provider/provider.dart';

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
    'Trade',
    'Create Account',
  ];
  //, Trade()];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final selectedCoin =
        Provider.of<SelectedCoinProvider>(context).coin ??
        CoinListModel(
          id: 'bitcoin',
          name: 'Bitcoin',
          symbol: '',
          currentPrice: 0,
          imageUrl: '',
          priceChangePercentage24h: '',
          high_24h: 0,
          low_24h: 0,
        ); // fallback

    final List<Widget> screens = [
      HomePage(),
      Account(),
      Follow(),
      Trade(coin: selectedCoin),
      CreateAccount(),
    ];

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
