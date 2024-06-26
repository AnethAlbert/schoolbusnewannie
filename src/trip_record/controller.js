// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');
const emailService = require("../services/mail_service");
const smsService = require("../services/sms_service");


// Send Notifications to Parent
function sendNotifications(student_id) {
  return new Promise((resolve, reject) => {
      // Retrieve student info
      pool.query(queries.getStudentInfo, [student_id], (error, studentInfoResults) => {
          if (error) {
              console.error(error);
              return reject({ status: 500, json: { success: false, message: 'Internal server error' } });
          }

          console.log('Student Info:', studentInfoResults[0]);

          // Retrieve parent info
          pool.query(queries.getParentInfo, [student_id], (error, parentResults) => {
              if (error) {
                  console.error(error);
                  return reject({ status: 500, json: { success: false, message: 'Internal server error' } });
              }

              if (!parentResults || parentResults.length === 0) {
                  console.log('Parent info not found for student:', student_id);
                  // Handle the case where parent info is not found
                  return reject({ status: 404, json: { success: false, message: 'Parent info not found' } });
              }

              console.log('Parent Info:', parentResults[0]);

              // Send notification to parent
              const parentEmail = parentResults[0].email;
              const parentPhone = parentResults[0].phone;
              const studentName = studentInfoResults[0].fname + ' ' + studentInfoResults[0].lname;
              const message = `Your student ${studentName} has been dropped off and has arrived at the destination address.`;

              // Send email
              emailService.sendEmail(parentEmail, "Student Arrived Confirmation.", message);

              // Send SMS
              smsService.sendSms(parentPhone, message);

              // Prepare response
              const response = {
                  student_info: studentInfoResults[0],
                  parent_info: parentResults[0],
                  message: 'Notification sent successfully',
                  success: true
              };

              return resolve({ status: 200, json: response });
          });
      });
  });
}



const addtrip = (req, res) => {
  const { routeid, gurdianid, description } = req.body;
  
  // Calculate the week number within the month
  const currentDate = new Date();
  const startOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
  const diff = currentDate.getDate() + startOfMonth.getDay() - 1;
  const weekof = Math.ceil(diff / 7);

  pool.query(queries.addTrip, [routeid, gurdianid, description, weekof], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    // Get the ID of the inserted row from the results
    const insertedId = results.insertId;
    console.log(insertedId);

    // Send the ID in the response
    res.status(201).json({ message: 'trip created successfully', id: insertedId });
    console.log(`trip created successfully with ID: ${insertedId}`);
  }); 
};


// const addtrip = (req, res) => {
//   const { routeid, gurdianid, description, weekof } = req.body;
//   pool.query(queries.addTrip, [routeid, gurdianid, description, weekof], (error, results) => {
//     if (error) {
//       console.error(error);
//       res.status(500).json({ error: 'Internal server error' });
//       return;
//     }

//     // Get the ID of the inserted row from the results
//     const insertedId = results.insertId;
//     console.log(insertedId);

//     // Send the ID in the response
//     res.status(201).json({ message: 'trip created successfully', id: insertedId });
//     console.log(`trip created successfully with ID: ${insertedId}`);
//   });
// };



//Get all getalltripRecords
const getalltripRecords = (req, res) => {
  pool.query(queries.GetalltripRecords, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results);
    console.log('Retrieved all stations');
  });
};

//Get tripRecord by id
const gettripRecordById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.GettripRecordById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    console.log(results);
    if (results=== 0) {  // Check if the array is empty
      res.status(404).json({ error: 'record not found' });
      return;
    }
    res.status(200).json(results);
    console.log(`Retrieved record with id: ${id}`);
  });
};


//Get tripRecord by guardian Id
const getActiveTripRecordByGuardianId = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.GetActiveTripRecordByGuardianId, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    console.log(results);
    if (results=== 0) {  // Check if the array is empty
      res.status(404).json({ error: 'record not found' });
      return;
    }
    res.status(200).json(results);
    console.log(`Retrieved record with id: ${id}`);
  });
};


//End tripRecord by Id
const updateTripStatusById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.UpdateTripStatusById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({success: false, message: 'Internal server error' });
      return;
    }
    console.log(results);
    if (results.affectedRows === 0) {  // Check if any rows were updated
      res.status(404).json({success: false, message: 'Record not found' });
      return;
    }
    res.status(200).json({success: true, message: 'Record updated successfully' });
    console.log(`Updated record with id: ${id}`);
  });
};


//Update Student trip Status
const updateStudentTripStatus = (req, res) => {
  const { studentId, tripId } = req.body;
  pool.query(queries.UpdateStudentTripStatus, [ tripId, studentId ], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({success: false, message: 'Internal server error' });
      return;
    }
    console.log(results);
    if (results.affectedRows === 0) {  // Check if any rows were updated
      res.status(404).json({success: false, message: 'Record not found' });
      return;
    }

    console.log(`Updated record with trip_id: ${tripId} and student_id: ${studentId}`);

    //Send Drop Off Notification to Parent
    sendNotifications(studentId)
        .then(result => res.status(result.status).json(result.json))
        .catch(error => res.status(error.status).json(error.json));
    
  });
};


//Get student Attendance by trip Id
const getStudentsAttendance = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.GetStudentsAttendance, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({success: false, message: 'Internal server error' });
      return;
    }
    console.log(results);
   
    res.status(200).json({success: true, data: results, message: 'Success' });
    console.log(`Data retrieved successfully`);
  });
};



// // Remove station by id
// const removestationById = (req, res) => {
//   const id = parseInt(req.params.id);
//   pool.query(queries.getStationById, [id], (error, results) => {
//     if (error) {
//       console.error(error);
//       res.status(500).json({ error: 'Internal server error' });
//       return;
//     }
//     if (!results.length) {
//       res.status(404).json({ error: 'station not found' });
//       return;
//     }
//     pool.query(queries.removeStationById, [id], (error, results) => {
//       if (error) {
//         console.error(error);
//         res.status(500).json({ error: 'Internal server error' });
//         return;
//       }
//       res.status(200).json({ message: 'station deleted successfully' });
//       console.log(`station with id: ${id} deleted successfully`);
//     });
//   });
// };

// Update trip by id

const updatetripById = (req, res) => {
        const id = parseInt(req.params.id);
        const {gurdianid } = req.body;
      
        // validate input
        if (!gurdianid) {
          res.status(400).send("Please provide a gurdianid for the trip");
          return;
        }
      
        pool.query(
          queries.GettripRecordById,
          [id],
          (error, results) => {
            if (error) {
              console.error(error);
              res.status(500).send("Error fetching trip from database");
              return;
            }
      
            const notripFound = !results.length;
            if (notripFound) {
              res.status(404).send("trip not found in the database");
              return;
            }
      
            // update trip in the database
            pool.query(
                queries.updateTripById,
              [gurdianid, id],
              (error, results) => {
                if (error) {
                  console.error(error);
                  res.status(500).send("Error updating trip in database");
                  return;
                }
      
                res.status(200).send("trip updated successfully");
                console.log("trip updated successfully!");
              }
            );
          }
        );
      };

      module.exports = {
        addtrip, 
        getalltripRecords,
        gettripRecordById,
        // removestationById,
        updatetripById,
        getActiveTripRecordByGuardianId,
        updateTripStatusById,
        getStudentsAttendance,
        updateStudentTripStatus
      };
