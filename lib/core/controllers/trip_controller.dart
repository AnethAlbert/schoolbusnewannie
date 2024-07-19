import 'package:newschoolbusapp/core/models/student_attendance_model.dart';

import '../services/Trip_apiService.dart';

class TripController {
  late TripApiService tripApiService;

  TripController() {
    tripApiService = TripApiService();
  }

  Future<int> fetchLastActiveTripId(int guardianId) async {
    int tripId = 0;
    try {
      tripId = await tripApiService.fetchLastActiveTripId(guardianId);
      return tripId;
    } catch (e) {
      return tripId;
    }
  }

  Future<bool> endTrip(int tripId) async {
    try {
      return await tripApiService.endTrip(tripId);
    } catch (e) {
      return false;
    }
  }

  Future<List<StudentAttendanceModel>> getStudentsAttendance(int tripId) async {
    return tripApiService.getStudentsAttendance(tripId);
  }

  Future<bool> dropStudent(int tripId, int studentId) async {
    return await tripApiService.dropStudent(tripId, studentId);
  }

  Future<void> openCloseDoor(String command) async {
    return tripApiService.openCloseDoor(command);
  }
}
