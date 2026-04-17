class BiomarkerModel {
  final String name;
  final String category;
  final double value;
  final String unit;
  final double low;
  final double optimal;
  final double high;
  final String status;

  BiomarkerModel({
    required this.name,
    required this.category,
    required this.value,
    required this.unit,
    required this.low,
    required this.optimal,
    required this.high,
    required this.status,
  });

  factory BiomarkerModel.fromJson(Map<String, dynamic> json) {
    return BiomarkerModel(
      name: json["name"] ?? "",
      category: json["category"] ?? "",
      value: (json["value"] ?? 0).toDouble(),
      unit: json["unit"] ?? "",
      low: (json["low"] ?? 0).toDouble(),
      optimal: (json["optimal"] ?? 0).toDouble(),
      high: (json["high"] ?? 0).toDouble(),
      status: json["status"] ?? "",
    );
  }
}
