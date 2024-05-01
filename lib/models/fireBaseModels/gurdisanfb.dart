import 'dart:convert';
import 'dart:typed_data';
class GurdianFB {
  final String? firebaseId;
  final int? mysqlId;
  final String? fname;
  final String? lname;
  final String? email;
  final String? phone;
  final String? profilepicture;
  final String? digitalfingerprint;
  final String? role;
  final DateTime? timestamp;
  final String? firestoreId; // Added firestoreId property

  GurdianFB({
    this.firebaseId,
    this.mysqlId,
    this.fname,
    this.lname,
    this.email,
    this.phone,
    this.profilepicture,
    this.digitalfingerprint,
    this.role,
    this.timestamp,
    this.firestoreId,
  });

  factory GurdianFB.fromJson(Map<String, dynamic> json) {
    return GurdianFB(
      firebaseId: json['firebaseId'] as String?,
      mysqlId: json['mysqlId'] as int?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profilepicture: json['profilepicture'] as String?,
      digitalfingerprint: json['digitalfingerprint'] as String?,
      role: json['role'] as String?,
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp'] as String) : null,
      firestoreId: json['firestoreId'] as String?, // Added firestoreId property
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firebaseId': firebaseId,
      'mysqlId': mysqlId,
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      'profilepicture': profilepicture,
      'digitalfingerprint': digitalfingerprint,
      'role': role,
      'timestamp': timestamp?.toIso8601String(),
      'firestoreId': firestoreId, // Added firestoreId property
    };
  }

  // Define copyWith method to create a new instance with updated values
  GurdianFB copyWith({
    String? firebaseId,
    int? mysqlId,
    String? fname,
    String? lname,
    String? email,
    String? phone,
    String? profilepicture,
    String? digitalfingerprint,
    String? role,
    DateTime? timestamp,
    String? firestoreId,
  }) {
    return GurdianFB(
      firebaseId: firebaseId ?? this.firebaseId,
      mysqlId: mysqlId ?? this.mysqlId,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilepicture: profilepicture ?? this.profilepicture,
      digitalfingerprint: digitalfingerprint ?? this.digitalfingerprint,
      role: role ?? this.role,
      timestamp: timestamp ?? this.timestamp,
      firestoreId: firestoreId ?? this.firestoreId,
    );
  }
}
