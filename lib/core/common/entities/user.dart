class User {
  final String id;
  final String firstName;
  final String? lastName;
  final String email;
  final String? phoneNumber;
  final String username;
  final String? location;
  final String? currency;
  final String? profilePicture;

  User({
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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
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

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? username,
    String? location,
    String? currency,
    String? profilePicture,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
      location: location ?? this.location,
      currency: currency ?? this.currency,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, username: $username, location: $location, currency: $currency, profilePicture: $profilePicture)';
  }
}