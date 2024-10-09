class User {
  final String firstName;
  final String? lastName;
  final String email;
  final String? phoneNumber;
  final String username;
  final String? location;
  final String? preferredCurrency;
  final String? profilePicture;

  User({
    required this.firstName,
    this.lastName,
    required this.email,
    this.phoneNumber,
    required this.username,
    this.location,
    this.preferredCurrency,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'username': username,
      'location': location,
      'preferredCurrency': preferredCurrency,
      'profilePicture': profilePicture,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'],
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'],
      username: map['username'] ?? '',
      location: map['location'],
      preferredCurrency: map['preferredCurrency'],
      profilePicture: map['profilePicture'],
    );
  }
}