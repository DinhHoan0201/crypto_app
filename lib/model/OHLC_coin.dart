class OHLCcoinModel {
  final double timestamp;
  final double open;
  final double high;
  final double low;
  final double close;

  OHLCcoinModel({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory OHLCcoinModel.fromJson(List<dynamic> json) {
    return OHLCcoinModel(
      timestamp: (json[0] as num).toDouble(),
      open: (json[1] as num).toDouble(),
      high: (json[2] as num).toDouble(),
      low: (json[3] as num).toDouble(),
      close: (json[4] as num).toDouble(),
    );
  }
}
