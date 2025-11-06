import 'package:flutter/material.dart';
import '../../../models/course_model.dart';
import '../../../services/api_service.dart';

class WishlistProvider with ChangeNotifier {
  List<Course> _wishlist = [];
  bool _isLoading = false;

  List<Course> get wishlist => _wishlist;
  bool get isLoading => _isLoading;

  Future<void> fetchWishlist() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.getWishlist();
      _wishlist = (response['courses'] as List)
          .map((json) => Course.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching wishlist: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addToWishlist(String courseId) async {
    try {
      await ApiService.addToWishlist(courseId);
      await fetchWishlist();
      return true;
    } catch (e) {
      print('Error adding to wishlist: $e');
      return false;
    }
  }

  Future<bool> removeFromWishlist(String courseId) async {
    try {
      await ApiService.removeFromWishlist(courseId);
      _wishlist.removeWhere((course) => course.id == courseId);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error removing from wishlist: $e');
      return false;
    }
  }

  bool isInWishlist(String courseId) {
    return _wishlist.any((course) => course.id == courseId);
  }

  void clearWishlist() {
    _wishlist = [];
    notifyListeners();
  }
}
