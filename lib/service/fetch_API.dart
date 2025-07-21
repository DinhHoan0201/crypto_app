import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto_app/model/OHLC_coin.dart';
import 'package:crypto_app/model/coinlist_model.dart';
import 'package:crypto_app/model/Line_coin.dart';

class CoinProvider with ChangeNotifier {
  List<CoinListModel> _coins = [];
  bool _isLoading = false;
  String? _error;

  List<CoinListModel> get coins => _coins;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCoins(int perpage, int page) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url =
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=$perpage&page=$page&sparkline=false';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _coins =
            (data as List).map((item) => CoinListModel.fromJson(item)).toList();
        _error = null;
      } else {
        _error = 'Failed to fetch coin list';
      }
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}

//

// Future<List<TimeValuePoint>> fetchCryptoChartdata(
//   String coinId,
//   int days,
// ) async {
//   final url =
//       'https://api.coingecko.com/api/v3/coins/$coinId/market_chart?vs_currency=usd&days=$days';

//   try {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 429) {
//       throw Exception('Rate limit exceeded. Please wait a moment.');
//     }
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final prices = data['prices'] as List;
//       return prices.map<TimeValuePoint>((item) {
//         return TimeValuePoint(value: (item[1] as num).toDouble());
//       }).toList();
//       //>
//     } else {
//       throw Exception('Failed to load crypto chart data');
//     }
//   } catch (error) {
//     print('Error fetching crypto chart data: $error');
//     rethrow;
//   }
// }

//
Future<List<OHLCcoinModel>> fetchOHLCdata(String coinId, int days) async {
  final url =
      'https://api.coingecko.com/api/v3/coins/$coinId/ohlc?vs_currency=usd&days=$days';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data as List)
          .map((item) => OHLCcoinModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load OHLC data');
    }
  } catch (error) {
    print('Error fetching  data: $error');
    rethrow;
  }
}
