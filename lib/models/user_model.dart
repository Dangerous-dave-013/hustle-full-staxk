class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final String? avatarUrl;
  final String? bio;
  final String? phoneNumber;
  final List<String> enrolledCourses;
  final List<String> wishlist;
  final List<String> completedCourses;
  final bool isInstructor;
  final String role;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.avatarUrl,
    this.bio,
    this.phoneNumber,
    this.enrolledCourses = const [],
    this.wishlist = const [],
    this.completedCourses = const [],
    this.isInstructor = false,
    this.role = 'student',
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'],
      avatarUrl: json['avatarUrl'],
      bio: json['bio'],
      phoneNumber: json['phoneNumber'],
      enrolledCourses: List<String>.from(json['enrolledCourses'] ?? []),
      wishlist: List<String>.from(json['wishlist'] ?? []),
      completedCourses: List<String>.from(json['completedCourses'] ?? []),
      isInstructor: json['isInstructor'] ?? json['role'] == 'instructor' ?? false,
      role: json['role'] ?? 'student',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'avatarUrl': avatarUrl,
      'bio': bio,
      'phoneNumber': phoneNumber,
      'enrolledCourses': enrolledCourses,
      'wishlist': wishlist,
      'completedCourses': completedCourses,
      'isInstructor': isInstructor,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  User copyWith({
    String? name,
    String? avatarUrl,
    String? bio,
    String? phoneNumber,
    List<String>? enrolledCourses,
    List<String>? wishlist,
    List<String>? completedCourses,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email,
      profileImage: profileImage,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      wishlist: wishlist ?? this.wishlist,
      completedCourses: completedCourses ?? this.completedCourses,
      isInstructor: isInstructor,
      role: role,
      createdAt: createdAt,
    );
  }
}
