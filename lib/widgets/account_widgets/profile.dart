import 'package:crypto_app/model/coinlist_model.dart';
import 'package:crypto_app/service/fetch_API.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto_app/model/users_data_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  final UserPortfolio userData;
  const Profile({super.key, required this.userData});
  @override
  Widget build(BuildContext context) {
    //
    final portfolioSymbols = userData.portfolio.keys.toList();
    final coinsInPortfolio =
        Provider.of<CoinProvider>(context, listen: false).coins
            .where(
              (coin) => portfolioSymbols.contains(coin.symbol.toLowerCase()),
            )
            .toList();
    // diaolog update
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _currentPasswordController =
        TextEditingController();
    final TextEditingController _newPasswordController =
        TextEditingController();
    //
    void _showUpdateDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update Profile'),
            content: Column(),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (userData.imgurl.isEmpty)
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey[700],
                      ),
                    )
                  else
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        userData.imgurl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  SizedBox(width: 10),
                  //
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userData.name),
                      GestureDetector(
                        onTap: () {
                          _showUpdateDialog();
                        },
                        child: Text(
                          'Click to edit profile',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Text("Đăng xuất"),
              ),

              //
            ],
          ),
          //
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 120,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      NumberFormat.currency(
                        locale: 'en_US',
                        symbol: '\$',
                      ).format(userData.balance),
                    ),
                    Text(
                      ' Current Balance',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),

                ///
                ElevatedButton(
                  child: Icon(Icons.add, color: Colors.black),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    //padding: EdgeInsets.all(7),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          //
          Divider(color: Colors.grey[300], thickness: 1, height: 40),

          // Followed Coins
          if (coinsInPortfolio.isNotEmpty)
            Column(
              children:
                  coinsInPortfolio.map((coin) {
                    final amount =
                        userData.portfolio[coin.symbol.toLowerCase()];
                    return ListTile(
                      leading: Image.network(
                        coin.imageUrl,
                        width: 25,
                        height: 25,
                      ),
                      title: Text(' $amount'),
                    );
                  }).toList(),
            )
          else
            Text("No coins found in portfolio"),
        ],
      ),
    );
  }
}
