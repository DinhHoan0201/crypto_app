class LineCoinModel {
  final List<TimeValuePoint> prices;
  final List<TimeValuePoint> market_caps;
  final List<TimeValuePoint> total_volumes;

  LineCoinModel({
    required this.prices,
    required this.market_caps,
    required this.total_volumes,
  });

  factory LineCoinModel.fromJson(Map<String, dynamic> json) {
    return LineCoinModel(
      prices:
          (json['prices'] as List)
              .map((item) => TimeValuePoint.fromJson(item))
              .toList(),
      market_caps:
          (json['market_casps'] as List)
              .map((item) => TimeValuePoint.fromJson(item))
              .toList(),
      total_volumes:
          (json['total_volumes'] as List)
              .map((item) => TimeValuePoint.fromJson(item))
              .toList(),
    );
  }
}

//
class TimeValuePoint {
  final double value;

  TimeValuePoint({required this.value});
  factory TimeValuePoint.fromJson(Map<String, dynamic> json) {
    return TimeValuePoint(value: json['value'].toDouble());
  }
}

//
