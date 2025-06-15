import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VolunteersScreen extends StatefulWidget {
  @override
  _VolunteersScreenState createState() => _VolunteersScreenState();
}

class _VolunteersScreenState extends State<VolunteersScreen> {
  final _auth = FirebaseAuth.instance;
  bool _loading = false;

  void _signUp() async {
    setState(() => _loading = true);
    final user = _auth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('volunteers').doc(user.uid).set({
        'email': user.email,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Volunteer Coordination')),
      body: Column(
        children: [
          SizedBox(height: 16),
          _loading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: _signUp,
                  child: Text('Sign Up as Volunteer'),
                ),
          SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('volunteers').orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, i) {
                    final data = docs[i].data() as Map<String, dynamic>;
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text(data['email'] ?? ''),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
