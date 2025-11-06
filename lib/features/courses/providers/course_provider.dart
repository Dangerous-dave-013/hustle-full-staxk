import 'package:flutter/material.dart';
import '../../../models/course_model.dart';
import '../../../services/api_service.dart';

class CourseProvider with ChangeNotifier {
  List<Course> _courses = [];
  List<Course> _enrolledCourses = [];
  Course? _selectedCourse;
  bool _isLoading = false;
  String? _errorMessage;

  List<Course> get courses => _courses;
  List<Course> get enrolledCourses => _enrolledCourses;
  Course? get selectedCourse => _selectedCourse;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCourses({String? category, String? search}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await ApiService.getCourses(category: category, search: search);
      _courses = (response['courses'] as List)
          .map((json) => Course.fromJson(json))
          .toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCourseById(String courseId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await ApiService.getCourseById(courseId);
      _selectedCourse = Course.fromJson(response['course']);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchEnrolledCourses() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await ApiService.getEnrolledCourses();
      _enrolledCourses = (response['courses'] as List)
          .map((json) => Course.fromJson(json))
          .toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isEnrolled(String courseId) {
    return _enrolledCourses.any((course) => course.id == courseId);
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearSelectedCourse() {
    _selectedCourse = null;
    notifyListeners();
  }
}
