
/*************trip_record**********/
 const addTrip = "INSERT INTO trip_record(routeid,gurdianid,description,weekof) VALUES (?,?,?,?)";
 const GetalltripRecords = "SELECT * FROM trip_record";
 const GettripRecordById = "SELECT * FROM trip_record WHERE id =?";
//  const GettripRecordById= "DELETE FROM trip_record WHERE id=?";
 const updateTripById= "UPDATE trip_record SET gurdianid = ? WHERE id = ?";
 const GetActiveTripRecordByGuardianId = "SELECT * FROM trip_record WHERE tripstatus = 'active' AND gurdianid = ? ORDER BY timestamp ASC LIMIT 1";
 const UpdateTripStatusById = "UPDATE trip_record SET tripstatus = 'completed' WHERE id = ?";

 const GetStudentsAttendance = `
    SELECT 
        s.registration_number,
        s.fname,
        s.lname,
        st.name AS station_name,
        stl.is_trip_finish
    FROM 
        student_trip_list stl
    JOIN 
        student s ON stl.student_id = s.id
    JOIN 
        station st ON s.station_id = st.id
    WHERE 
        stl.trip_id = ?;
    `;

const UpdateStudentTripStatus = "UPDATE student_trip_list SET is_trip_finish = 1  WHERE trip_id = ? AND student_id = ?";

// Query to get student information by student_id
const getStudentInfo = `
  SELECT *
  FROM student
  WHERE id = ?;
`;

// Query to get parent information by student_id
const getParentInfo = `
  SELECT parent.*
  FROM parent
  JOIN parent_student_relation ON parent.id = parent_student_relation.parent_id
  WHERE parent_student_relation.student_id = ?;
`;
    




module.exports={
    addTrip,
    GetalltripRecords,
   // getTripById,
    GettripRecordById,
    updateTripById,
    GetActiveTripRecordByGuardianId,
    UpdateTripStatusById,
    GetStudentsAttendance,
    UpdateStudentTripStatus,
    getStudentInfo,
    getParentInfo
} 