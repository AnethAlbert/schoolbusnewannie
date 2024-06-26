class Student {
  final int? id;
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

  Student(
     {
        this.id,
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



factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int?,
      mysqlId:json['mysqlId'] as int?,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mysqlId':mysqlId,
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
