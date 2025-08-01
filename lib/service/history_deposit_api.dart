import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_app/constant/firebase_path.dart';
import 'package:crypto_app/model/history_deposit.dart';

Future<HistoryDeposit?> getHistoryDeposit() async {
  final users = FirebaseAuth.instance.currentUser;
  if (users == null) return null;
  final doc =
      await FirebaseFirestore.instance
          .collection(FireStorePath.topLevel1)
          .doc(users.uid)
          .get();
  if (doc.exists == null) return null;
  final userhistorydeposit = HistoryDeposit.fromMap(doc.data()!);
  return userhistorydeposit;
}

Future<void> addData(double amount, Timestamp timestamp) async {
  final users = FirebaseAuth.instance.currentUser;
  if (users == null) return null;

  //
  await FirebaseFirestore.instance
      .collection(FireStorePath.topLevel1)
      .add({'amount': amount, 'timestapmp': timestamp})
      .then((value) => print('add Data successs'))
      .catchError((e) => print('Failed $e'));
}

//
