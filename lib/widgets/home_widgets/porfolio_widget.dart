import 'package:crypto_app/model/coinlist_model.dart';
import 'package:crypto_app/screen/main_screen.dart';
import 'package:crypto_app/service/fetch_API.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto_app/service/fetch_data_users.dart';
import 'package:crypto_app/model/users_data_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:crypto_app/service/notification.dart';

class PortfolioWidget extends StatefulWidget {
  const PortfolioWidget({super.key});
  @override
  _PortfolioWidgetState createState() => _PortfolioWidgetState();
}

class _PortfolioWidgetState extends State<PortfolioWidget> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<CoinProvider>(context, listen: false).fetchCoins(3, 1);
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    void _navigatortoLogin() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(initialIndex: 1),
        ),
      );
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final user = snapshot.data;
        if (user == null) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Explore the World of Digital Assets ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: _navigatortoLogin,
                      child: const Text(
                        "Login/Sign in",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),

                Lottie.asset(
                  'images/assets/Bitcoin.json',
                  width: 150,
                  height: 150,
                ),
              ],
            ),
          );
        } else {
          return Consumer<CoinProvider>(
            builder: (context, coinProvider, _) {
              if (coinProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return FutureBuilder<UserPortfolio?>(
                future: getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Lỗi: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('Không có dữ liệu portfolio');
                  } else {
                    final portfolio = snapshot.data!;
                    //
                    double totalValue = 0;

                    portfolio.portfolio.forEach((symbol, amount) {
                      final coin = coinProvider.coins.firstWhere(
                        (c) => c.symbol == symbol,
                        orElse: () => CoinListModel.empty(),
                      );

                      final value = amount * coin.currentPrice ?? 0;
                      print("🪙 $symbol: amount=$amount,value=$value");

                      totalValue += value;
                    });

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // ElevatedButton(
                          //   onPressed: () {
                          //     Notificationservice().showNotification(
                          //       title: 'Portfolio Update',
                          //       body: 'hello',
                          //     );
                          //   },
                          //   child: Text("click here to see notification"),
                          // ),

                          // ...coinWidgets,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Portfolio",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      portfolio.name,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(height: 5),

                                    Text(
                                      "\$${portfolio.balance.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.green.withOpacity(0.1),
                                    border: Border.all(
                                      color: Colors.green,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                    ),
                                    '\$${totalValue.toStringAsFixed(0)}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  'Buy Crypto by your Credit Card',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Transform.scale(
                                scale: 2,
                                child: Lottie.asset(
                                  'images/assets/CreditCard.json',
                                  width: 150,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          );
        }
      },
    );
  }
}
