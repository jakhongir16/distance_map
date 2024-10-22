class Trip {
  final DateTime date;
  final double distance;
  final double totalAmount;

  Trip({
    required this.date,
    required this.distance,
    required this.totalAmount
    });

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'totalAmount': totalAmount,
      'date': date.toIso8601String(),
    };
  }

  static Trip fromJson(Map<String, dynamic> json) {
    return Trip(
      distance: json['distance'],
      totalAmount: json['totalAmount'],
      date: DateTime.parse(json['date']),
    );
  }

}