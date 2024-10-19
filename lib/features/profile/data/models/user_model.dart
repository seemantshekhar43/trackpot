import '../../../../core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.firstName,
    super.lastName,
    required super.email,
    super.phoneNumber,
    required super.username,
    super.location,
    super.currency,
    super.profilePicture,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['\$id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'],
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'],
      username: map['username'] ?? '',
      location: map['location'],
      currency: map['currency'],
      profilePicture: map['profilePicture'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'username': username,
      'location': location,
      'currency': currency,
      'profilePicture': profilePicture,
    };
  }
}