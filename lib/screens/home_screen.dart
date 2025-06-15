import 'package:flutter/material.dart';
import 'alert_screen.dart';
import 'report_screen.dart';
import 'chat_screen.dart';
import 'resources_screen.dart';
import 'volunteers_screen.dart';
import 'tips_screen.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('EchoAlert'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => auth.signOut(),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.warning, color: Colors.red),
            title: Text('Send Emergency Alert'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AlertScreen())),
          ),
          ListTile(
            leading: Icon(Icons.report),
            title: Text('Report Incident'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportScreen())),
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Community Chat'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen())),
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Contacts & Resources'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ResourcesScreen())),
          ),
          ListTile(
            leading: Icon(Icons.volunteer_activism),
            title: Text('Volunteer Coordination'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VolunteersScreen())),
          ),
          ListTile(
            leading: Icon(Icons.tips_and_updates),
            title: Text('Safety Tips & Announcements'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TipsScreen())),
          ),
        ],
      ),
    );
  }
}