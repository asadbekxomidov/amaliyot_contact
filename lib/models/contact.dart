class Contact {
  int id;
  String contactName;
  String phoneNumber;

  Contact({
    required this.id,
    required this.contactName,
    required this.phoneNumber,
  });

  // Convert a Contact into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contactName': contactName,
      'phoneNumber': phoneNumber,
    };
  }

  // Extract a Contact from a Map.
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      contactName: map['contactName'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
