class Message {
  final String id;
  final String text;
  final String sender;
  final DateTime timestamp;

  Message({required this.id, required this.text, required this.sender, required this.timestamp});

  factory Message.fromFirestore(Map<String, dynamic> data, String id) {
    return Message(
      id: id,
      text: data['text'] ?? '',
      sender: data['sender'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
