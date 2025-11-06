class Course {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final double price;
  final String instructorId;
  final String instructorName;
  final String? instructorImage;
  final List<Lesson> lessons;
  final String category;
  final String level;
  final int enrolledCount;
  final double rating;
  final int reviewCount;
  final List<String> requirements;
  final List<String> learningOutcomes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.price,
    required this.instructorId,
    required this.instructorName,
    this.instructorImage,
    this.lessons = const [],
    required this.category,
    required this.level,
    this.enrolledCount = 0,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.requirements = const [],
    this.learningOutcomes = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      instructorId: json['instructorId'] ?? json['instructor']?['_id'] ?? '',
      instructorName: json['instructorName'] ?? json['instructor']?['name'] ?? '',
      instructorImage: json['instructorImage'] ?? json['instructor']?['profileImage'],
      lessons: (json['lessons'] as List<dynamic>?)
              ?.map((lesson) => Lesson.fromJson(lesson))
              .toList() ??
          [],
      category: json['category'] ?? '',
      level: json['level'] ?? 'Beginner',
      enrolledCount: json['enrolledCount'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      requirements: List<String>.from(json['requirements'] ?? []),
      learningOutcomes: List<String>.from(json['learningOutcomes'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'price': price,
      'instructorId': instructorId,
      'instructorName': instructorName,
      'instructorImage': instructorImage,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
      'category': category,
      'level': level,
      'enrolledCount': enrolledCount,
      'rating': rating,
      'reviewCount': reviewCount,
      'requirements': requirements,
      'learningOutcomes': learningOutcomes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get totalDuration {
    final totalMinutes = lessons.fold<int>(0, (sum, lesson) => sum + lesson.duration);
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }
}

class Lesson {
  final String id;
  final String title;
  final String videoUrl;
  final int duration; // in minutes
  final int order;
  final String? description;

  Lesson({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.duration,
    required this.order,
    this.description,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      duration: json['duration'] ?? 0,
      order: json['order'] ?? 0,
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'videoUrl': videoUrl,
      'duration': duration,
      'order': order,
      'description': description,
    };
  }
}
