import 'package:flutter/material.dart';
import 'package:crypto_app/widgets/follow_widgets/coin_list.dart';
import 'package:crypto_app/screen/main_screen.dart';
import 'package:crypto_app/service/fetch_API.dart';
import 'package:provider/provider.dart';
import 'package:crypto_app/model/coinlist_model.dart';

class Body extends StatefulWidget {
  const Body({super.key});
  State<Body> createState() => _Body();
}

class _Body extends State<Body> {
  @override
  List<CoinListModel> allcoins = [];
  bool isLoading = true;
  String error = '';
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final coinProvider = Provider.of<CoinProvider>(context, listen: false);
      coinProvider
          .fetchCoins(10, 1)
          .then((_) {
            setState(() {
              allcoins = coinProvider.coins;
              isLoading = false;
            });
          })
          .catchError((e) {
            setState(() {
              error = e.toString();
              isLoading = false;
            });
          });
    });
  }

  void _navigatortoFollow() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(initialIndex: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Coins',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: _navigatortoFollow,
                  child: Text(
                    'More',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),
          Expanded(child: CoinList(coins: allcoins)),
        ],
      ),
    );
  }
}
