import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';
  
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  
  static Future<Map<String, String>> _getHeaders({bool includeAuth = true}) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    
    if (includeAuth) {
      final token = await _getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    
    return headers;
  }
  
  // Auth APIs
  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: await _getHeaders(includeAuth: false),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
  
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: await _getHeaders(includeAuth: false),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
  
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/profile'),
        headers: await _getHeaders(),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }
  
  // Course APIs
  static Future<Map<String, dynamic>> getCourses({String? category, String? search}) async {
    try {
      var url = '$baseUrl/courses';
      final queryParams = <String, String>{};
      
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      
      if (queryParams.isNotEmpty) {
        url += '?' + queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
      }
      
      final response = await http.get(
        Uri.parse(url),
        headers: await _getHeaders(includeAuth: false),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch courses: $e');
    }
  }
  
  static Future<Map<String, dynamic>> getCourseById(String courseId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/courses/$courseId'),
        headers: await _getHeaders(includeAuth: false),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch course: $e');
    }
  }
  
  static Future<Map<String, dynamic>> getEnrolledCourses() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/courses/enrolled'),
        headers: await _getHeaders(),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch enrolled courses: $e');
    }
  }
  
  // Payment APIs
  static Future<Map<String, dynamic>> createPaymentIntent(List<String> courseIds) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/payment/create-intent'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'courseIds': courseIds,
        }),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to create payment intent: $e');
    }
  }

  // Fake payment gateway APIs
  static Future<Map<String, dynamic>> createFakeSession(List<String> courseIds, {String? method}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/payment/fake/create-session'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'courseIds': courseIds,
          if (method != null) 'method': method,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to create fake payment session: $e');
    }
  }

  static Future<Map<String, dynamic>> processFakePayment(String sessionId, String method, Map<String, dynamic> details) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/payment/fake/process'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'sessionId': sessionId,
          'method': method,
          'details': details,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to process fake payment: $e');
    }
  }

  static Future<Map<String, dynamic>> getFakePaymentMethods() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/payment/fake/methods'),
        headers: await _getHeaders(),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch fake payment methods: $e');
    }
  }
  
  static Future<Map<String, dynamic>> confirmPayment(String paymentIntentId, List<String> courseIds) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/payment/confirm'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'paymentIntentId': paymentIntentId,
          'courseIds': courseIds,
        }),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to confirm payment: $e');
    }
  }
  
  // Create Course (Instructor)
  static Future<Map<String, dynamic>> createCourse(Map<String, dynamic> courseData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/courses'),
        headers: await _getHeaders(),
        body: jsonEncode(courseData),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to create course: $e');
    }
  }
  
  // Profile APIs
  static Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? bio,
    String? phoneNumber,
    String? avatarUrl,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/auth/profile'),
        headers: await _getHeaders(),
        body: jsonEncode({
          if (name != null) 'name': name,
          if (bio != null) 'bio': bio,
          if (phoneNumber != null) 'phoneNumber': phoneNumber,
          if (avatarUrl != null) 'avatarUrl': avatarUrl,
        }),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
  
  // Wishlist APIs
  static Future<Map<String, dynamic>> addToWishlist(String courseId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/wishlist/add'),
        headers: await _getHeaders(),
        body: jsonEncode({'courseId': courseId}),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
  }
  
  static Future<Map<String, dynamic>> removeFromWishlist(String courseId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/wishlist/remove/$courseId'),
        headers: await _getHeaders(),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }
  
  static Future<Map<String, dynamic>> getWishlist() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/wishlist'),
        headers: await _getHeaders(),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch wishlist: $e');
    }
  }
  
  // Progress APIs
  static Future<Map<String, dynamic>> updateProgress({
    required String courseId,
    required String lessonId,
    required int watchedSeconds,
    required bool isCompleted,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/progress/update'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'courseId': courseId,
          'lessonId': lessonId,
          'watchedSeconds': watchedSeconds,
          'isCompleted': isCompleted,
        }),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to update progress: $e');
    }
  }
  
  static Future<Map<String, dynamic>> getProgress(String courseId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/progress/$courseId'),
        headers: await _getHeaders(),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch progress: $e');
    }
  }
  
  // Review APIs
  static Future<Map<String, dynamic>> addReview({
    required String courseId,
    required int rating,
    required String comment,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reviews'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'courseId': courseId,
          'rating': rating,
          'comment': comment,
        }),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to add review: $e');
    }
  }
  
  static Future<Map<String, dynamic>> getReviews(String courseId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/reviews/$courseId'),
        headers: await _getHeaders(includeAuth: false),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch reviews: $e');
    }
  }
  
  static Future<Map<String, dynamic>> markReviewHelpful(String reviewId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reviews/$reviewId/helpful'),
        headers: await _getHeaders(),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to mark review helpful: $e');
    }
  }
  
  // Certificate API
  static Future<Map<String, dynamic>> getCertificate(String courseId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/certificates/$courseId'),
        headers: await _getHeaders(),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch certificate: $e');
    }
  }
  
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['message'] ?? 'Request failed with status ${response.statusCode}');
    }
  }
}
