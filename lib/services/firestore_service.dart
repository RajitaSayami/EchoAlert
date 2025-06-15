import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/incident_model.dart';
import '../models/message_model.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Stream<List<Incident>> getIncidents() {
    return _db.collection('incidents').orderBy('timestamp', descending: true).snapshots().map(
      (snap) => snap.docs.map((doc) => Incident.fromFirestore(doc.data(), doc.id)).toList(),
    );
  }

  Stream<List<Message>> getMessages() {
    return _db.collection('messages').orderBy('timestamp', descending: true).snapshots().map(
      (snap) => snap.docs.map((doc) => Message.fromFirestore(doc.data(), doc.id)).toList(),
    );
  }

  Stream<List<Map<String, dynamic>>> getTips() {
    return _db.collection('tips').orderBy('timestamp', descending: true).snapshots().map(
      (snap) => snap.docs.map((doc) => doc.data()).toList(),
    );
  }
}
