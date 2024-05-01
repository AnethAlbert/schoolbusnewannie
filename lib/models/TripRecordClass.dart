class TripRecord {
  final int? id;
  final int? busId;
  final int? routeId;
  final int? pickupStationId;
  final int? dropStationId;
  final int? guardianId;
  final int? studentId;
  final String? description;
  final String? tripStatus;
  final int? weekOf;
  final DateTime? timestamp;

  TripRecord({
     this.id,
     this.busId,
     this.routeId,
     this.pickupStationId,
     this.dropStationId,
     this.guardianId,
     this.studentId,
     this.description,
     this.tripStatus,
     this.weekOf,
     this.timestamp,
  }) ;

  factory TripRecord.fromJson(Map<String, dynamic> json) {
    return TripRecord(
      id: json['id'] as int?,
      busId: json['bus_id'] as int?,
      routeId: json['routeid'] as int?,
      pickupStationId: json['pickupstationid'] as int?,
      dropStationId: json['dropstationid'] as int?,
      guardianId: json['gurdianid'] as int?,
      studentId: json['studentid'] as int?,
      description: json['description'] as String?,
      tripStatus: json['tripstatus'] as String?,
      weekOf: json['weekof'] as int?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bus_id': busId,
      'routeid': routeId,
      'pickupstationid': pickupStationId,
      'dropstationid': dropStationId,
      'gurdianid': guardianId,
      'studentid': studentId,
      'description': description,
      'tripstatus': tripStatus,
      'weekof': weekOf,
      'timestamp': timestamp?.toIso8601String(), // Convert DateTime? to String?
    };
  }
}
