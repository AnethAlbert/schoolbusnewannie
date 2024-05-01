class Student_trip_list {
  final int? trip_id;
  final int? student_id;


  Student_trip_list({
  this.trip_id,
    this.student_id
  }) ;

  factory Student_trip_list.fromJson(Map<String, dynamic> json) {
    return Student_trip_list(
      trip_id: json['trip_id'] as int?,
      student_id: json['student_id'] as int?,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip_id': trip_id,
      'student_id': student_id,
  // Convert DateTime? to String?
    };
  }
}
