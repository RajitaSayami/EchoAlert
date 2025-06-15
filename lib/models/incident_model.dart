class Incident {
  final String id;
  final String type;
  final String description;
  final DateTime timestamp;

  Incident({required this.id, required this.type, required this.description, required this.timestamp});

  factory Incident.fromFirestore(Map<String, dynamic> data, String id) {
    return Incident(
      id: id,
      type: data['type'] ?? '',
      description: data['description'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
