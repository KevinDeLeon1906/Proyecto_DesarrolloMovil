class User {
  final String id;
  final String username;
  final String email;
  String? profileImagePath;
  String? fullName;
  String? phoneNumber;
  List<String> favoriteHouseIds;
  Map<String, dynamic>? preferences;
  DateTime createdAt;
  DateTime lastLoginAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.profileImagePath,
    this.fullName,
    this.phoneNumber,
    List<String>? favoriteHouseIds,
    this.preferences,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) :
        favoriteHouseIds = favoriteHouseIds ?? [],
        createdAt = createdAt ?? DateTime.now(),
        lastLoginAt = lastLoginAt ?? DateTime.now();

  // Create a User from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      profileImagePath: json['profileImagePath'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      favoriteHouseIds: List<String>.from(json['favoriteHouseIds'] ?? []),
      preferences: json['preferences'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'])
          : null,
    );
  }

  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profileImagePath': profileImagePath,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'favoriteHouseIds': favoriteHouseIds,
      'preferences': preferences,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt.toIso8601String(),
    };
  }

  // Create a copy of the user with updated fields
  User copyWith({
    String? id,
    String? username,
    String? email,
    String? profileImagePath,
    String? fullName,
    String? phoneNumber,
    List<String>? favoriteHouseIds,
    Map<String, dynamic>? preferences,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      favoriteHouseIds: favoriteHouseIds ?? this.favoriteHouseIds,
      preferences: preferences ?? this.preferences,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}