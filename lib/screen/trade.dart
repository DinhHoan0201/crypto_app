import 'package:crypto_app/service/data_users_api.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/model/coinlist_model.dart';
import 'package:crypto_app/shared/candle_chart.dart';
import 'package:provider/provider.dart';
import 'package:crypto_app/service/notification.dart';

class Trade extends StatelessWidget {
  final CoinListModel coin;
  const Trade({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final double? priceChange = double.tryParse(
      coin.priceChangePercentage24h ?? ' ',
    );
    final bool isNegative = priceChange != null && priceChange < 0;
    double average = (coin.high_24h + coin.low_24h) / 2;
    final List<Map<String, dynamic>> valuein24h = [
      {'label': 'High', 'value': coin.high_24h},
      {'label': 'Low', 'value': coin.low_24h},
      {'label': 'Average', 'value': average},
    ];
    //
    void _Buycoin(String symbol, double amount, double currentPrice) {
      double tempAmount = amount;
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Chọn số lượng $symbol"),
                    Text("Giá hiện tại: $currentPrice"),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Icon(Icons.remove, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(5),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            setState(() {
                              if (tempAmount > 1) tempAmount -= 1;
                              if (tempAmount <= 0) tempAmount = 0;
                            });
                          },
                        ),
                        Text(
                          tempAmount.toStringAsFixed(1),
                          style: TextStyle(fontSize: 20),
                        ),
                        ElevatedButton(
                          child: Icon(Icons.add, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(5),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            setState(() {
                              tempAmount += 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), // Hủy dialog
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17),
                      child: Text("Hủy"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addCoin(symbol, amount, currentPrice);
                      //
                      print("Xác nhận mua $tempAmount $symbol");
                      //
                      Notificationservice().showNotification(
                        title: 'Click to check',
                        body:
                            'You already bought ${tempAmount}  ${coin.symbol}',
                      );
                      Navigator.pop(context);
                    },
                    child: Text("Xác nhận"),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    //
    void _Sellcoin(String symbol, double amount, double currentPrice) {
      double tempAmount = amount;
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Chọn số lượng $symbol"),
                    Text("Giá hiện tại: $currentPrice"),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Icon(Icons.remove, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(5),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            setState(() {
                              if (tempAmount > 1) tempAmount -= 1;
                              if (tempAmount <= 0) tempAmount = 0;
                            });
                          },
                        ),
                        Text(
                          tempAmount.toStringAsFixed(1),
                          style: TextStyle(fontSize: 20),
                        ),
                        ElevatedButton(
                          child: Icon(Icons.add, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(5),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            setState(() {
                              tempAmount += 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), // Hủy dialog
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17),
                      child: Text("Hủy"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      sellCoin(symbol, amount, currentPrice);
                      print("Xác nhận mua $tempAmount $symbol");
                      Navigator.pop(context);
                    },
                    child: Text("Xác nhận"),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(coin.imageUrl)),
                    const SizedBox(width: 6),
                    Text(
                      coin.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                Container(
                  width: 91,
                  height: 35,
                  decoration: BoxDecoration(
                    color: isNegative ? Colors.red[100] : Colors.green[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${priceChange?.toStringAsFixed(2) ?? '--'}%',
                        style: TextStyle(
                          color: isNegative ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        isNegative ? Icons.arrow_downward : Icons.arrow_upward,
                        size: 16,
                        color: isNegative ? Colors.red : Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var value in valuein24h)
                  Container(
                    height: 61,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 30,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value['label'].toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          value['value'] > 1000
                              ? value['value'].toStringAsFixed(0)
                              : value['value'].toStringAsFixed(3),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            //
            CandleChart(coinId: coin.id),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 170,
                  child: TextButton(
                    onPressed: () {
                      _Buycoin(coin.symbol, 1.0, coin.currentPrice);
                      //noitifacaation
                    },
                    child: Text('Buy', style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),

                Container(
                  width: 170,
                  child: TextButton(
                    onPressed: () {
                      _Sellcoin(coin.symbol, 1.0, coin.currentPrice);
                    },
                    child: Text('Sell', style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
