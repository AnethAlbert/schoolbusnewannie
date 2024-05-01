class ParentStudentRelation {
  final String? parentId;
  final String? studentId;
  final DateTime? timestamp;

  ParentStudentRelation({
    this.parentId,
    this.studentId,
    this.timestamp,
  });

  factory ParentStudentRelation.fromJson(Map<String, dynamic> json) {
    return ParentStudentRelation(
      parentId: json['parent_id'] as String?,
      studentId: json['student_id'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
    );
  }

  ParentStudentRelation copyWith({
    String? parentId,
    String? studentId,
    DateTime? timestamp,
  }) {
    return ParentStudentRelation(
      parentId: parentId ?? this.parentId,
      studentId: studentId ?? this.studentId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parent_id': parentId,
      'student_id': studentId,
    };
  }
}
