
class Parent {
  final int? id;
  final int? mysqlId;
  final String? fname;
  final String? lname;
  final String? email;
  final String? phone;
  String? profilepicture;
  final String? password;
  final DateTime? timestamp;

  // Add the docId field
  String? docId;

  Parent({
    this.id,
    this.mysqlId,
    this.fname,
    this.lname,
    this.email,
    this.phone,
    this.profilepicture,
    this.password,
    this.timestamp,
    // Add the docId parameter to the constructor
    this.docId,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['id'] as int?,
      mysqlId: json['mysqlId'] as int?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profilepicture: json['profilepicture'] as String?,
      password: json['password'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
      // Initialize docId from JSON
      docId: json['docId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mysqlId':mysqlId,
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      'profilepicture': profilepicture,
      'password': password,
      'timestamp': timestamp?.toIso8601String(),
      // Include docId in the JSON representation
      'docId': docId,
    };
  }
}















// class Parent {
//   final int? id;
//   final int? mysqlId;
//   final String? fname;
//   final String? lname;
//   final String? email;
//   final String? phone;
//   final String? profilepicture;
//   final String? password;
//   final DateTime? timestamp;
//
//   Parent({
//     this.id,
//     this.mysqlId,
//     this.fname,
//     this.lname,
//     this.email,
//     this.phone,
//     this.profilepicture,
//     this.password,
//
//     this.timestamp,
//   });
//
//   factory Parent.fromJson(Map<String, dynamic> json) {
//     return Parent(
//       id: json['id'] as int?,
//       mysqlId: json['mysqlId'] as int?,
//       fname: json['fname'] as String?,
//       lname: json['lname'] as String?,
//       email: json['email'] as String?,
//       phone: json['phone'] as String?,
//       profilepicture: json['profilepicture'] as String?,
//       password: json['password'] as String?,
//       timestamp: json['timestamp'] != null
//           ? DateTime.parse(json['timestamp'] as String)
//           : null,
//     );
//   }
//
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'mysqlId':mysqlId,
//       'fname': fname,
//       'lname': lname,
//       'email': email,
//       'phone': phone,
//       'profilepicture': profilepicture,
//       'password': password,
//       'timestamp': timestamp?.toIso8601String(),
//     };
//   }
// }
