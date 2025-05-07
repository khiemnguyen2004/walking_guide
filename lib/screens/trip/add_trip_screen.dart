import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen({super.key});

  @override
  State<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  final _tripNameController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _saveTrip() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || _tripNameController.text.isEmpty || _startDate == null || _endDate == null) return;

    final tripRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('trips')
        .doc();

    await tripRef.set({
      'name': _tripNameController.text.trim(),
      'startDate': _startDate,
      'endDate': _endDate,
    });

    Navigator.pop(context); // Quay lại màn hình trước
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm hành trình')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tripNameController,
              decoration: const InputDecoration(labelText: 'Tên hành trình'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_startDate == null
                    ? 'Chọn ngày bắt đầu'
                    : 'Bắt đầu: ${_startDate!.toLocal().toString().split(' ')[0]}'),
                ElevatedButton(
                  onPressed: () => _pickDate(context, true),
                  child: const Text('Chọn'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_endDate == null
                    ? 'Chọn ngày kết thúc'
                    : 'Kết thúc: ${_endDate!.toLocal().toString().split(' ')[0]}'),
                ElevatedButton(
                  onPressed: () => _pickDate(context, false),
                  child: const Text('Chọn'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveTrip,
              child: const Text('Lưu hành trình'),
            ),
          ],
        ),
      ),
    );
  }
}
