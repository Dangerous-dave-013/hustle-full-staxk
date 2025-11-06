import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../models/cart_model.dart';
import '../../../models/course_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;
  
  int get itemCount => _items.length;
  
  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.price);
  }

  CartProvider() {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    
    if (cartData != null) {
      final List<dynamic> decoded = jsonDecode(cartData);
      _items = decoded.map((json) => CartItem.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = jsonEncode(_items.map((item) => item.toJson()).toList());
    await prefs.setString('cart', cartData);
  }

  void addToCart(Course course) {
    // Check if already in cart
    if (_items.any((item) => item.courseId == course.id)) {
      return;
    }

    _items.add(CartItem(
      courseId: course.id,
      title: course.title,
      thumbnail: course.thumbnail,
      price: course.price,
      instructorName: course.instructorName,
    ));

    _saveCart();
    notifyListeners();
  }

  void removeFromCart(String courseId) {
    _items.removeWhere((item) => item.courseId == courseId);
    _saveCart();
    notifyListeners();
  }

  bool isInCart(String courseId) {
    return _items.any((item) => item.courseId == courseId);
  }

  void clearCart() {
    _items.clear();
    _saveCart();
    notifyListeners();
  }

  List<String> getCourseIds() {
    return _items.map((item) => item.courseId).toList();
  }
}
