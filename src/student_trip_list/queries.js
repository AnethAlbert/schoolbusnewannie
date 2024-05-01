// queries.js

// Query to check if a student exists by student_id
const checkStudentExists = `
  SELECT id
  FROM student
  WHERE id = ?;
`;

// Query to add a student to the student_trip_list table
const addStudentToTripList = `
  INSERT INTO student_trip_list (trip_id, student_id)
  VALUES (?, ?);
`;

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



// Query to get all student ids
const getAllStudentIds = `
  SELECT student_id
  FROM student_trip_list;
`;

// Query to get student ids by trip id
const getStudentIdsByTripId = `
select student_id from student_trip_list where trip_id = ?;
`;

module.exports = {
  checkStudentExists,
  addStudentToTripList,
  getStudentInfo,
  getParentInfo,
  getAllStudentIds,
  getStudentIdsByTripId
};