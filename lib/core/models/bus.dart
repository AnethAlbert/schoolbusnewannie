class Bus {
  final int? id;
  final String? registrationNumber;
  final String? model;
  final int? capacity;
  final DateTime? timestamp;

  Bus({
    this.id,
    this.registrationNumber,
    this.model,
    this.capacity,
    this.timestamp,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id'] as int?,
      registrationNumber: json['registration_number'] as String?,
      model: json['model'] as String?,
      capacity: json['capacity'] as int?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'registration_number': registrationNumber,
      'model': model,
      'capacity': capacity,
      'timestamp': timestamp?.toIso8601String(),
    };
  }
}
