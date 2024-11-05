import '../entities/user.dart';

class UserModel {
  final String id;
  final String firstName;
  final String? lastName;
  final String email;
  final String? phoneNumber;
  final String username;
  final String? location;
  final String? currency;
  final String? profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.email,
    this.phoneNumber,
    required this.username,
    this.location,
    this.currency,
    this.profilePicture,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['\$id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'],
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'],
      username: map['username'] ?? '',
      location: map['location'] ?? '',
      currency: map['currency'],
      profilePicture: map['profilePicture'],
    );
  }

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

  User toEntity() {
    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      username: username,
      location: location,
      currency: currency,
      profilePicture: profilePicture,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      username: user.username,
      location: user.location,
      currency: user.currency,
      profilePicture: user.profilePicture,
    );
  }
}
