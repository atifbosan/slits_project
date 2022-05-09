class UserModel {
  String? user_id;
  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  String? user_type;

  UserModel(
      {this.user_id,
      required this.email,
      required this.name,
      required this.phoneNumber,
      required this.password,
      this.user_type = "User"});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      user_id: map['user_id'],
      email: map['email'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      user_type: map['user_type'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'password': password,
      'user_type': user_type,
    };
  }
}
