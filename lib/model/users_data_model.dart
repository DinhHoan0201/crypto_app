class UserPortfolio {
  final String name;
  final double balance;
  final Map<String, double> portfolio;

  UserPortfolio({
    required this.name,
    required this.balance,
    required this.portfolio,
  });

  factory UserPortfolio.fromMap(Map<String, dynamic> map) {
    final rawPortfolio = map['portfolio'] as Map<String, dynamic>? ?? {};

    final portfolio = <String, double>{};
    rawPortfolio.forEach((key, value) {
      portfolio[key] = (value as num).toDouble();
    });

    return UserPortfolio(
      name: map['name'] ?? '',
      balance: (map['balance'] ?? 0).toDouble(),
      portfolio: portfolio,
    );
  }
}
