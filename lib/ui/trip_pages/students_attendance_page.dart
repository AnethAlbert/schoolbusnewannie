import 'package:flutter/material.dart';
import 'package:newschoolbusapp/core/models/student_attendance_model.dart';
import 'package:newschoolbusapp/core/utils/app_colors.dart';
import 'package:newschoolbusapp/widgets/custom_loader.dart';

import '../../core/controllers/trip_controller.dart';

class StudentAttendancePage extends StatefulWidget {
  final int tripId;

  const StudentAttendancePage({super.key, required this.tripId});

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  late TripController tripController;
  List<StudentAttendanceModel> attendanceList = [];
  bool loading = false;

  @override
  void initState() {
    tripController = TripController();
    super.initState();
    getAttendance();
  }

  Future<void> getAttendance() async {
    loading = true;
    setState(() {});
    attendanceList = await tripController.getStudentsAttendance(widget.tripId);
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Students Attendance"),
        ),
        body: Column(
          children: [
            Table(
              border: TableBorder.all(color: Colors.grey),
              children: const <TableRow>[
                TableRow(
                  decoration: BoxDecoration(
                    color: AppColors.linearMiddle,
                  ),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Reg No.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "First\nname",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Last\nname",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Station",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Status",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            loading
                ? const CustomLoader()
                : Expanded(
                    child: ListView.builder(
                      itemCount: attendanceList.length,
                      itemBuilder: (context, index) {
                        bool even = index % 2 == 0;
                        StudentAttendanceModel student = attendanceList[index];
                        return Table(
                          border: TableBorder.all(color: Colors.black26),
                          children: <TableRow>[
                            TableRow(
                              decoration: BoxDecoration(
                                color: even
                                    ? Colors.white
                                    : AppColors.greyColor.withOpacity(0.5),
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    student.regNo,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    student.firstName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    student.lastName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    student.station,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    student.isTripCompleted
                                        ? "Completed"
                                        : "On-Trip",
                                    style: TextStyle(
                                      color: student.isTripCompleted
                                          ? Colors.green
                                          : Colors.black,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
