import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../services/api_service.dart';
import '../../cart/providers/cart_provider.dart';
import '../../courses/providers/course_provider.dart';
import 'dart:async';

class FakePaymentAppScreen extends StatefulWidget {
  final String sessionId;
  final String method;
  final double amount;

  const FakePaymentAppScreen({super.key, required this.sessionId, required this.method, required this.amount});

  @override
  State<FakePaymentAppScreen> createState() => _FakePaymentAppScreenState();
}

class _FakePaymentAppScreenState extends State<FakePaymentAppScreen> {
  bool _processing = false;
  final _cardNumberController = TextEditingController();
  final _identifierController = TextEditingController();

  Future<void> _pay() async {
    setState(() => _processing = true);
    try {
      Map<String, dynamic> details = {};
      if (widget.method == 'card') {
        details['cardNumber'] = _cardNumberController.text.trim();
      } else if (widget.method == 'wallet') {
        details = {};
      } else {
        details['identifier'] = _identifierController.text.trim();
      }

      final resp = await ApiService.processFakePayment(widget.sessionId, widget.method, details);

      if (resp['success'] == true) {
        if (context.mounted) {
          // Clear cart and refresh courses
          Provider.of<CartProvider>(context, listen: false).clearCart();
          await Provider.of<CourseProvider>(context, listen: false).fetchEnrolledCourses();
          
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment succeeded! Courses added to your library.'), backgroundColor: Colors.green));
          // Navigate to my courses
          context.go('/my-courses');
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment failed: $e'), backgroundColor: Colors.red));
      }
    } finally {
      setState(() => _processing = false);
    }
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _identifierController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fake Payment - ${widget.method.toUpperCase()}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Paying: \$${widget.amount.toStringAsFixed(2)}", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            if (widget.method == 'card') ...[
              const Text('Enter fake card details (use digits 12-19 chars)'),
              const SizedBox(height: 8),
              TextField(controller: _cardNumberController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Card Number')),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _processing ? null : _pay, child: _processing ? const CircularProgressIndicator() : const Text('Pay')),
            ] else if (widget.method == 'upi') ...[
              const Text('Choose a UPI app and enter UPI ID (eg: user@upi)'),
              const SizedBox(height: 8),
              TextField(controller: _identifierController, decoration: const InputDecoration(labelText: 'UPI ID (e.g. user@upi)')),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _processing ? null : _pay, child: _processing ? const CircularProgressIndicator() : const Text('Pay with UPI')),
            ] else if (widget.method == 'netbanking') ...[
              const Text('Select bank and enter identifier'),
              const SizedBox(height: 8),
              TextField(controller: _identifierController, decoration: const InputDecoration(labelText: 'Account / Identifier')),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _processing ? null : _pay, child: _processing ? const CircularProgressIndicator() : const Text('Pay with Netbanking')),
            ] else if (widget.method == 'applepay') ...[
              const Text('Simulated Apple Pay flow'),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _processing ? null : _pay, child: _processing ? const CircularProgressIndicator() : const Text('Pay with Apple Pay')),
            ] else if (widget.method == 'wallet') ...[
              const Text('Use your Hustle Wallet (fake balance shown on profile)'),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _processing ? null : _pay, child: _processing ? const CircularProgressIndicator() : const Text('Pay from Wallet')),
            ],
          ],
        ),
      ),
    );
  }
}
