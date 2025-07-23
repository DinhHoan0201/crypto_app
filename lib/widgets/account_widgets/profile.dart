import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto_app/model/users_data_model.dart';

class Profile extends StatelessWidget {
  final String email;
  final UserPortfolio userData;

  const Profile({super.key, required this.email, required this.userData});
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(75), // bo tròn
            child: Image.network(
              userData.imgurl,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          //
          SizedBox(height: 20),
          Text(userData.name),
          Text(userData.balance.toString()),
          Text(userData.portfolio['btc'].toString()),
          Text(userData.portfolio['eth'].toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: const Text("Đăng xuất"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
