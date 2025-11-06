import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/api_service.dart';

class PaymentOptionsScreen extends StatefulWidget {
  final List<String> courseIds;
  const PaymentOptionsScreen({super.key, required this.courseIds});

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  bool _loading = false;
  String? _sessionId;
  double? _amount;
  List<String> _methods = [];

  Future<void> _createSession() async {
    setState(() => _loading = true);
    try {
      final resp = await ApiService.createFakeSession(widget.courseIds);
      setState(() {
        _sessionId = resp['sessionId'];
        _amount = (resp['amount'] as num).toDouble();
        _methods = List<String>.from(resp['methodOptions'] ?? []);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error creating session: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _createSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Payment Method')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Amount: \$${_amount?.toStringAsFixed(2) ?? '0.00'}", style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  const Text('Select a payment method:'),
                  const SizedBox(height: 12),
                  ..._methods.map((m) => ListTile(
                        title: Text(_prettyName(m)),
                        leading: const Icon(Icons.payment),
                        onTap: () {
                          if (_sessionId == null) return;
                          // Navigate to fake payment app screen
                          context.go('/fake-pay/${_sessionId}?method=$m&amount=${_amount ?? 0}');
                        },
                      )),
                ],
              ),
            ),
    );
  }

  String _prettyName(String id) {
    switch (id) {
      case 'card':
        return 'Credit / Debit Card';
      case 'upi':
        return 'UPI (GPay / PhonePe)';
      case 'wallet':
        return 'Hustle Wallet (Fake)';
      case 'netbanking':
        return 'Net Banking';
      case 'applepay':
        return 'Apple Pay';
      default:
        return id;
    }
  }
}
