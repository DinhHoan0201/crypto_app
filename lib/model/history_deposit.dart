import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryDeposit {
  final double amount;
  final Timestamp timestamp;
  HistoryDeposit({required this.amount, required this.timestamp});

  factory HistoryDeposit.fromMap(Map<String, dynamic> map) {
    return HistoryDeposit(
      amount: map['amount'] ?? '',
      timestamp: map['timestamp'] ?? '',
    );
  }
  // add data
  Map<String, dynamic> toMap() {
    return {'amount': amount, 'timestamp': timestamp};
  }
}
