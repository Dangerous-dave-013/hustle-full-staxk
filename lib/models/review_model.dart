class ReviewModel {
  final String id;
  final String courseId;
  final String userId;
  final String userName;
  final String? userAvatar;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final int helpfulCount;
  final List<String> helpfulBy;
  final String? instructorResponse;
  final DateTime? responseDate;

  ReviewModel({
    required this.id,
    required this.courseId,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.helpfulCount = 0,
    this.helpfulBy = const [],
    this.instructorResponse,
    this.responseDate,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'] ?? json['id'] ?? '',
      courseId: json['courseId'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? 'Anonymous',
      userAvatar: json['userAvatar'],
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      helpfulCount: json['helpfulCount'] ?? 0,
      helpfulBy: List<String>.from(json['helpfulBy'] ?? []),
      instructorResponse: json['instructorResponse'],
      responseDate: json['responseDate'] != null
          ? DateTime.parse(json['responseDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'helpfulCount': helpfulCount,
      'helpfulBy': helpfulBy,
      'instructorResponse': instructorResponse,
      'responseDate': responseDate?.toIso8601String(),
    };
  }
}
