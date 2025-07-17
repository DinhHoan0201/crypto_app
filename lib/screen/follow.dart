import 'package:flutter/material.dart';
import 'package:crypto_app/widgets/follow_widgets/coin_list.dart';
import 'package:crypto_app/widgets/follow_widgets/category_selector.dart';
import 'package:crypto_app/widgets/follow_widgets/search_filter.dart';
import 'package:crypto_app/model/coinlist_model.dart';
import 'package:crypto_app/service/fetch_API.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class Follow extends StatefulWidget {
  const Follow({super.key});
  State<Follow> createState() => _Follow();
}

class _Follow extends State<Follow> {
  List<CoinListModel> allcoins = [];
  List<CoinListModel> filteredCoins = [];
  Timer? _debounce;
  bool isLoading = true;
  int selectedIndex = 0;
  String error = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final coinProvider = Provider.of<CoinProvider>(context, listen: false);
      coinProvider
          .fetchCoins(10, 1)
          .then((_) {
            setState(() {
              allcoins = coinProvider.coins;
              filteredCoins = coinProvider.coins;
              isLoading = false;
            });
          })
          .catchError((e) {
            setState(() {
              error = e.toString();
              isLoading = false;
            });
          });
    });
  }

  void handlecategoryTap(int index) {
    if (_debounce?.isActive ?? false) return _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {});
    setState(() {
      selectedIndex = index;
      if (index == 0 || index == 3) {
        filteredCoins = allcoins;
      } else {
        filteredCoins = [];
      }
    });
  }

  void _onSearch(String keyword) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        if (keyword.isEmpty) {
          filteredCoins = allcoins;
        } else {
          filteredCoins =
              allcoins
                  .where(
                    (coin) =>
                        coin.name.toLowerCase().contains(keyword.toLowerCase()),
                  )
                  .toList();
        }
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        SearchFilter(
          hintText: "Search assets...",
          icon: Icons.search,
          settingsIcon: Icons.tune,
          onChanged: _onSearch,
        ),
        const SizedBox(height: 10),
        CategorySelector(
          selectedIndex: selectedIndex,
          onCategoryTap: handlecategoryTap,
        ),
        SizedBox(height: 5),
        Expanded(child: CoinList(coins: filteredCoins)),
      ],
    );
  }
}
