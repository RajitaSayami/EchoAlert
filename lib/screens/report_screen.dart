import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? _selectedType;
  final _descController = TextEditingController();
  File? _image;
  bool _loading = false;
  final List<String> _types = ['Fire', 'Medical', 'Security', 'Other'];

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  void _reportIncident() async {
    if (_selectedType == null || _descController.text.isEmpty) return;
    setState(() => _loading = true);
    // For demo: just save text data. For real app, upload image to Firebase Storage and save URL.
    await FirebaseFirestore.instance.collection('incidents').add({
      'type': _selectedType,
      'description': _descController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });
    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incident reported!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report Incident')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedType,
              items: _types.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
              onChanged: (val) => setState(() => _selectedType = val),
              decoration: InputDecoration(labelText: 'Incident Type'),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.camera_alt),
                  label: Text('Add Photo'),
                ),
                if (_image != null) Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Image.file(_image!, width: 50, height: 50),
                ),
              ],
            ),
            SizedBox(height: 16),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _reportIncident,
                    child: Text('Report'),
                  ),
          ],
        ),
      ),
    );
  }
}
