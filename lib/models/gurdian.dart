import 'dart:typed_data';



class Gurdian {
  final int? id;
  final int? mysqlId;
  final String? fname;
  final String? lname;
  final String? email;
  final String? phone;
  final String? profilepicture;
  final String? digitalfingerprint;
  final String? role;
  final String? password;
  final DateTime? timestamp;

  Gurdian({
    this.id,
    this.mysqlId,
    this.fname,
    this.lname,
    this.email,
    this.phone,
    this.profilepicture,
    this.digitalfingerprint,
    this.role,
    this.password,
    this.timestamp,
  });

  factory Gurdian.fromJson(Map<String, dynamic> json) {
    return Gurdian(
      id: json['id'] as int?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profilepicture: json['profilepicture'] as String?,
      digitalfingerprint: json['digitalfingerprint'] as String?,
      role: json['role'] as String?,
      password: json['password'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mysqlId': mysqlId,
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      'profilepicture': profilepicture,
      'digitalfingerprint': digitalfingerprint,
      'role': role,
      'password': password,
      'timestamp': timestamp?.toIso8601String(),
    };
  }
}

