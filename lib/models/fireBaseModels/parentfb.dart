import 'package:cloud_firestore/cloud_firestore.dart';

class ParentFB {
  final String? firebaseId;
  final int? mysqlId;
  final String? fname;
  final String? lname;
  final String? email;
  final String? phone;
  final String? profilepicture;
  final String? password;
  final DateTime? timestamp;

  ParentFB({
    this.firebaseId,
    this.mysqlId,
    this.fname,
    this.lname,
    this.email,
    this.phone,
    this.profilepicture,
    this.password,
    this.timestamp,
  });

  factory ParentFB.fromJson(Map<String, dynamic> json) {
    return ParentFB(
      firebaseId: json['firebaseId'] as String?,
      mysqlId: json['mysqlId'] as int?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profilepicture: json['profilepicture'] as String?,
      password: json['password'] as String?,
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp'] as String) : null,
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
      'password': password,
       'timestamp': timestamp,
    };
  }


  // Define a factory constructor to create a Parent object from a Firestore document
  factory ParentFB.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return ParentFB(
      firebaseId: data['firebaseId'],
      mysqlId: data['mysqlId'],
      fname: data['fname'],
      lname: data['lname'],
      email: data['email'],
      phone: data['phone'],
      profilepicture: data['profilepicture'],
    );
  }

// Define copyWith method to create a new instance with updated values
  ParentFB copyWith({
    String? firebaseId,
    int? mysqlId,
    String? fname,
    String? lname,
    String? email,
    String? phone,
    String? profilepicture,
    String? digitalfingerprint,
    String? role,
     Timestamp? timestamp,
    String? firestoreId,
  }) {
    return ParentFB(
      firebaseId: firebaseId ?? this.firebaseId,
      mysqlId: mysqlId ?? this.mysqlId,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilepicture: profilepicture ?? this.profilepicture,
     // timestamp: timestamp ?? this.timestamp,
    );
  }
}