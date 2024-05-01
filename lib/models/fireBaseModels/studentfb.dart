class StudentFB {
  final String? firebaseId;
  final int? mysqlId;
  final String? fname;
  final String? lname;
  final int? class_id;
  final int? station_id;
  final String? registration_number;
  final int? age;
  final String? profilepicture;
  final String? digitalfingerprint;
  final DateTime? timestamp;

  StudentFB({
    this.firebaseId,
    this.mysqlId,
    this.fname,
    this.lname,
    this.class_id,
    this.station_id,
    this.registration_number,
    this.age,
    this.profilepicture,
    this.digitalfingerprint,
    this.timestamp,
  });

  factory StudentFB.fromJson(Map<String, dynamic> json) {
    return StudentFB(
      firebaseId: json['firebaseId'] as String?,
      mysqlId: json['mysqlId'] as int?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      class_id: json['class_id'] as int?,
      station_id: json['station_id'] as int?,
      registration_number: json['registration_number'] as String?,
      age: json['age'] as int?,
      profilepicture: json['profilepicture'] as String?,
      digitalfingerprint: json['digitalfingerprint'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
    );
  }

  StudentFB copyWith({
    String? fireaseId,
    int? mysqlId,
    String? fname,
    String? lname,
    int? class_id,
    int? station_id,
    String? registration_number,
    int? age,
    String? profilepicture,
    String? digitalfingerprint,
    DateTime? timestamp,
  }) {
    return StudentFB(
      firebaseId: firebaseId ?? this.firebaseId,
      mysqlId: mysqlId ?? this.mysqlId,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      class_id: class_id ?? this.class_id,
      station_id: station_id ?? this.station_id,
      registration_number: registration_number ?? this.registration_number,
      age: age ?? this.age,
      profilepicture: profilepicture ?? this.profilepicture,
      digitalfingerprint: digitalfingerprint ?? this.digitalfingerprint,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firebaseId': firebaseId,
      'mysqlId': mysqlId,
      'fname': fname,
      'lname': lname,
      'class_id': class_id,
      'station_id': station_id,
      'registration_number': registration_number,
      'age': age,
      'profilepicture': profilepicture,
      'digitalfingerprint': digitalfingerprint,
      'timestamp': timestamp?.toIso8601String(),
    };
  }
}
