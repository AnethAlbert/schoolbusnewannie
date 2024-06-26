
class Class {
  final int? id;
  final String? code;
  final String? name;
  final int? capacity;
  final DateTime? timestamp;

  Class({
     this.id,
    this.code,
     this.name,
    this.capacity,
     this.timestamp,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'] as int,
      code: json['code'] as String?,
      name: json['name'] as String,
      capacity: json['capacity'] as int?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'capacity': capacity,
      'timestamp': timestamp?.toIso8601String(),
    };
  }
}
