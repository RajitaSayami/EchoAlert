import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesScreen extends StatelessWidget {
  final List<Map<String, String>> resources = [
    {'name': 'Police', 'phone': '100'},
    {'name': 'Fire', 'phone': '101'},
    {'name': 'Ambulance', 'phone': '102'},
    {'name': 'Local Volunteer', 'phone': '1234567890'},
  ];

  void _call(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts & Resources')),
      body: ListView(
        children: resources.map((res) => ListTile(
          leading: Icon(Icons.phone),
          title: Text(res['name']!),
          subtitle: Text(res['phone']!),
          trailing: IconButton(
            icon: Icon(Icons.call),
            onPressed: () => _call(res['phone']!),
          ),
        )).toList(),
      ),
    );
  }
}
