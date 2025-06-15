import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  String? _selectedType;
  final _descController = TextEditingController();
  bool _loading = false;
  final List<String> _types = ['Fire', 'Medical', 'Security', 'Other'];

  void _sendAlert() async {
    if (_selectedType == null || _descController.text.isEmpty) return;
    setState(() => _loading = true);
    await FirebaseFirestore.instance.collection('alerts').add({
      'type': _selectedType,
      'description': _descController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });
    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Alert sent!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Emergency Alert')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedType,
              items: _types.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
              onChanged: (val) => setState(() => _selectedType = val),
              decoration: InputDecoration(labelText: 'Alert Type'),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _sendAlert,
                    child: Text('Send Alert'),
                  ),
          ],
        ),
      ),
    );
  }
}
