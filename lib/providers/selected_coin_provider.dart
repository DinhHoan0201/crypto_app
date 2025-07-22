import 'package:crypto_app/model/coinlist_model.dart';
import 'package:flutter/material.dart';

class SelectedCoinProvider extends ChangeNotifier {
  CoinListModel? _selectedCoin;

  CoinListModel? get coin => _selectedCoin;

  void setCoin(CoinListModel coin) {
    _selectedCoin = coin;
    notifyListeners();
  }
}
