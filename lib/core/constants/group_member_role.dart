enum GroupMemberRole {
  admin,
  member;

  // Converts enum to a string for easy storage or display
  String toMap() => name;

  // Parses a string back into the enum
  static GroupMemberRole fromMap(String role) {
    return GroupMemberRole.values.firstWhere(
          (e) => e.name == role,
      orElse: () => GroupMemberRole.member, // default or fallback if needed
    );
  }
}
