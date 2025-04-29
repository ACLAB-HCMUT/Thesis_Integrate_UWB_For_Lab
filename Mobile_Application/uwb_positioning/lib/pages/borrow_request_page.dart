import 'package:flutter/material.dart';
import 'package:uwb_positioning/services/borrow_request_service.dart';
import 'package:uwb_positioning/models/borrow_request.dart';  // Import model BorrowRequest

class BorrowRequestPage extends StatefulWidget {
  static const nameRoute = '/borrow-request';
  const BorrowRequestPage({Key? key}) : super(key: key);

  @override
  _BorrowRequestPageState createState() => _BorrowRequestPageState();
}

class _BorrowRequestPageState extends State<BorrowRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _detailCtl = TextEditingController();
  final _statusCtl = TextEditingController(text: 'pending');
  final _appointmentCtl = TextEditingController();
  final _expectedReturnCtl = TextEditingController();
  final _clientCtl = TextEditingController();

  final _service = BorrowRequestService();

  Future<void> _submit(String deviceId) async {
    if (!_formKey.currentState!.validate()) return;

    // Create a BorrowRequest instance instead of a Map
    final request = BorrowRequest(
      deviceId: deviceId,
      detail: _detailCtl.text,
      status: _statusCtl.text,
      appointmentDate: _appointmentCtl.text,
      expectedReturn: _expectedReturnCtl.text,
      clientId: _clientCtl.text,
    );

    final success = await _service.createRequest(request);  // Pass the BorrowRequest object

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Borrow request created ✔')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error submitting request ❌')),
      );
    }
  }

  @override
  void dispose() {
    _detailCtl.dispose();
    _statusCtl.dispose();
    _appointmentCtl.dispose();
    _expectedReturnCtl.dispose();
    _clientCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final deviceId = args is String ? args : args?.toString() ?? 'unknown';
    return Scaffold(
      appBar: AppBar(title: const Text('Borrow Request')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Device ID: $deviceId'),
              const SizedBox(height: 12),
              TextFormField(
                controller: _detailCtl,
                decoration: const InputDecoration(labelText: 'Detail'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _appointmentCtl,
                decoration: const InputDecoration(labelText: 'Appointment Date'),
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (d != null) _appointmentCtl.text = d.toIso8601String();
                },
                readOnly: true,
              ),
              TextFormField(
                controller: _expectedReturnCtl,
                decoration: const InputDecoration(labelText: 'Expected Return'),
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (d != null) _expectedReturnCtl.text = d.toIso8601String();
                },
                readOnly: true,
              ),
              // TextFormField(
              //   controller: _clientCtl,
              //   decoration: const InputDecoration(labelText: 'Client ID'),
              //   validator: (v) => v!.isEmpty ? 'Required' : null,
              // ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submit(deviceId),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
