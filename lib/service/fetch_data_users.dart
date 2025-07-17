import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_app/constant/firebase_path.dart';
import 'package:crypto_app/model/users_data_model.dart';

Future<UserPortfolio?> getUserData() async {
  final users = FirebaseAuth.instance.currentUser;
  if (users == null) return null;
  final doc =
      await FirebaseFirestore.instance
          .collection(FireStorePath.topLevel)
          .doc(users.uid)
          .get();
  if (!doc.exists) return null;

  final userData = UserPortfolio.fromMap(doc.data()!);
  return userData;
}
