import 'package:flutter/material.dart';
import 'package:crypto_app/model/coinlist_model.dart';
import 'package:crypto_app/widgets/trade_widgets/candle_chart.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text('Trade')),
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
                          value['value'].toString(),
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
                    onPressed: () {},
                    child: Text('Buy', style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(backgroundColor: Colors.yellow),
                  ),
                ),

                Container(
                  width: 170,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Sell', style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(backgroundColor: Colors.yellow),
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
