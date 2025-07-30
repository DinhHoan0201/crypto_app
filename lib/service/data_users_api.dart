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

//change password
Future<void> changePassword(String currentPassword, String newPassword) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;
  final credential = EmailAuthProvider.credential(
    email: user.email!,
    password: currentPassword,
  );
  try {
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
    print('Password changed successfully');
  } catch (e) {
    print('Error changing password: $e');
  }
}

Future<void> addData(UserPortfolio userData) async {
  final users = FirebaseAuth.instance.currentUser;
  if (users == null) return;

  await FirebaseFirestore.instance
      .collection(FireStorePath.topLevel)
      .doc(users.uid)
      .set(userData.toMap());
}

//
void addCoin(String symbol, double amount, double currentPrice) async {
  final userData = await getUserData();
  if (userData == null) return;

  final updatedPortfolio = Map<String, double>.from(userData.portfolio);
  updatedPortfolio[symbol] = (updatedPortfolio[symbol] ?? 0) + amount;
  final updatedBalance = userData.balance - (currentPrice * amount);

  final updatedUserData = UserPortfolio(
    name: userData.name,
    balance: updatedBalance,
    portfolio: updatedPortfolio,
    imgurl: userData.imgurl,
  );

  await addData(updatedUserData);
}

//

void sellCoin(String symbol, double amount, double currentPrice) async {
  final userData = await getUserData();
  if (userData == null) return;

  final updatedPortfolio = Map<String, double>.from(userData.portfolio);
  if (updatedPortfolio[symbol] != null) {
    updatedPortfolio[symbol] = (updatedPortfolio[symbol] ?? 0) - amount;
    if (updatedPortfolio[symbol]! <= 0) {
      updatedPortfolio.remove(symbol);
    }
  }

  final updatedBalance = userData.balance + (currentPrice * amount);

  final updatedUserData = UserPortfolio(
    name: userData.name,
    balance: updatedBalance,
    portfolio: updatedPortfolio,
    imgurl: userData.imgurl,
  );

  await addData(updatedUserData);
}

//
