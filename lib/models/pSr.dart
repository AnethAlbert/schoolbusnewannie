class ParentStudentRelation {
  final int? id;
  final int? parentId;
  final int? studentId;

  ParentStudentRelation({
    this.id,
    this.parentId,
    this.studentId,
  });

  factory ParentStudentRelation.fromJson(Map<String, dynamic> json) {
    return ParentStudentRelation(
      id: json['id'] as int,
      parentId: json['parent_id'] as int?,
      studentId: json['student_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'student_id': studentId,
    };
  }
}
