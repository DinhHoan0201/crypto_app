class CoinListModel {
  final String id;
  final String name;
  final String symbol;
  final double currentPrice;
  final String imageUrl;
  final String? priceChangePercentage24h;
  final double high_24h;
  final double low_24h;

  CoinListModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.imageUrl,
    required this.priceChangePercentage24h,
    required this.high_24h,
    required this.low_24h,
  });

  factory CoinListModel.fromJson(Map<String, dynamic> json) {
    return CoinListModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      currentPrice: json['current_price'].toDouble(),
      imageUrl: json['image'],
      priceChangePercentage24h: json['price_change_percentage_24h']?.toString(),
      high_24h: json['high_24h'].toDouble(),
      low_24h: json['low_24h'].toDouble(),
    );
  }

  factory CoinListModel.empty() {
    return CoinListModel(
      id: '',
      symbol: '',
      name: '',
      currentPrice: 0.0,
      imageUrl: '',
      priceChangePercentage24h: null,
      high_24h: 0.0,
      low_24h: 0.0,
    );
  }
}
