class StudentAttendanceModel {
  final String firstName;
  final String lastName;
  final String regNo;
  final String station;
  final bool isTripCompleted;

  StudentAttendanceModel({
    required this.firstName,
    required this.isTripCompleted,
    required this.lastName,
    required this.regNo,
    required this.station,
  });

  factory StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceModel(
      firstName: json['fname'] ?? "_",
      lastName: json['lname'] ?? "_",
      regNo: json['registration_number'] ?? "_",
      station: json['station_name'] ?? "_",
      isTripCompleted: int.parse(json['is_trip_finish'].toString()) == 1,
    );
  }
}
