class UserModel {
  final String? id;
  final String name;
  final String email;
  final String photoBase64;
  final String gender;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.photoBase64,
    required this.gender,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photoBase64: data['photoBase64'] ?? '',
      gender: data['gender'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "photoBase64": photoBase64,
      "gender": gender,
    };
  }
}
