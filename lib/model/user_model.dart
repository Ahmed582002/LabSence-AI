class UserModel {
  final String? id;
  final String name;
  final String email;
  final String photoBase64;
  final String gender;
  final String phone;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.photoBase64,
    required this.gender,
    required this.phone,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photoBase64: data['photoBase64'] ?? '',
      gender: data['gender'] ?? '',
      phone: data['phone'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "photoBase64": photoBase64,
      "gender": gender,
      "phone": phone,
    };
  }
}
