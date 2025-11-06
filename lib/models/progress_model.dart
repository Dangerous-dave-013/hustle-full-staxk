class CourseProgress {
  final String courseId;
  final String userId;
  final List<String> completedLessons;
  final double progressPercentage;
  final DateTime lastWatched;
  final Map<String, int> lessonProgress; // lessonId -> seconds watched
  final bool isCompleted;
  final DateTime? completedAt;

  CourseProgress({
    required this.courseId,
    required this.userId,
    required this.completedLessons,
    required this.progressPercentage,
    required this.lastWatched,
    required this.lessonProgress,
    this.isCompleted = false,
    this.completedAt,
  });

  factory CourseProgress.fromJson(Map<String, dynamic> json) {
    return CourseProgress(
      courseId: json['courseId'] ?? '',
      userId: json['userId'] ?? '',
      completedLessons: List<String>.from(json['completedLessons'] ?? []),
      progressPercentage: (json['progressPercentage'] ?? 0).toDouble(),
      lastWatched: json['lastWatched'] != null
          ? DateTime.parse(json['lastWatched'])
          : DateTime.now(),
      lessonProgress: Map<String, int>.from(json['lessonProgress'] ?? {}),
      isCompleted: json['isCompleted'] ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'userId': userId,
      'completedLessons': completedLessons,
      'progressPercentage': progressPercentage,
      'lastWatched': lastWatched.toIso8601String(),
      'lessonProgress': lessonProgress,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  CourseProgress copyWith({
    List<String>? completedLessons,
    double? progressPercentage,
    DateTime? lastWatched,
    Map<String, int>? lessonProgress,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return CourseProgress(
      courseId: courseId,
      userId: userId,
      completedLessons: completedLessons ?? this.completedLessons,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      lastWatched: lastWatched ?? this.lastWatched,
      lessonProgress: lessonProgress ?? this.lessonProgress,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
