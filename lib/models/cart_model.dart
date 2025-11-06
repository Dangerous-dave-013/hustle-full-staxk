class CartItem {
  final String courseId;
  final String title;
  final String thumbnail;
  final double price;
  final String instructorName;

  CartItem({
    required this.courseId,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.instructorName,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      courseId: json['courseId'] ?? '',
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      instructorName: json['instructorName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
      'instructorName': instructorName,
    };
  }
}
