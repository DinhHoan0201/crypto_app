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
          if (userData.imgurl.isEmpty)
            CircleAvatar(
              radius: 75,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 75, color: Colors.grey[700]),
            )
          else
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
          //
          Column(
            children:
                userData.portfolio.entries.map((entry) {
                  return Text('${entry.key}: ${entry.value}');
                }).toList(),
          ),

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
