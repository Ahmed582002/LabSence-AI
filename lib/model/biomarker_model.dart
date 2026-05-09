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
    double parseDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is int) return v.toDouble();
      if (v is double) return v;
      if (v is String) return double.tryParse(v) ?? 0.0;
      return 0.0;
    }

    return BiomarkerModel(
      name: json["name"] ?? "",
      category: json["category"] ?? "",
      value: parseDouble(json["value"]),
      unit: json["unit"] ?? "",
      low: parseDouble(json["low"]),
      optimal: parseDouble(json["optimal"]),
      high: parseDouble(json["high"]),
      status: json["status"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "category": category,
      "value": value,
      "unit": unit,
      "low": low,
      "optimal": optimal,
      "high": high,
      "status": status,
    };
  }
}
