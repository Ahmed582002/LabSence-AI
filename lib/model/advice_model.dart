class AdviceModel {
  final String title;
  final String description;
  final String priority;
  final String action;
  final String category;

  AdviceModel({
    required this.title,
    required this.description,
    required this.priority,
    required this.action,
    required this.category,
  });

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      priority: json["priority"] ?? "low",
      action: json["action"] ?? "",
      category: json["category"] ?? "",
    );
  }
}
