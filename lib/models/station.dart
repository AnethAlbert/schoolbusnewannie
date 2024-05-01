class Station {
  final int? id;
  final String? code;
  final String? name;
  final DateTime? timestamp;

  Station({
     this.id,
    this.code,
     this.name,
     this.timestamp,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'] as int,
      code: json['code'] as String?,
      name: json['name'] as String,
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
      'timestamp': timestamp?.toIso8601String(),
    };
  }
}
