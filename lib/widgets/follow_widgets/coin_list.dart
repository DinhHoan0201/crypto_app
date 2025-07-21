import 'package:flutter/material.dart';
import 'package:crypto_app/model/coinlist_model.dart';

import 'package:crypto_app/screen/trade.dart';

class CoinList extends StatelessWidget {
  final List<CoinListModel> coins;
  const CoinList({Key? key, required this.coins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: coins.length,
      itemBuilder: (context, index) {
        final coin = coins[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Container(
            height: 70,
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
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Trade(coin: coin)),
                );
              },
              child: Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(coin.imageUrl),
                        ),
                        SizedBox(width: 10),
                        Text(
                          coin.name,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    ///
                    Row(
                      children: [
                        //
                        SizedBox(
                          width: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${coin.currentPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              if (coin.priceChangePercentage24h != null)
                                Text(
                                  '${coin.priceChangePercentage24h}%',
                                  style: TextStyle(
                                    color:
                                        double.tryParse(
                                                  coin.priceChangePercentage24h!,
                                                )! <
                                                0
                                            ? Colors.red
                                            : Colors.green,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
