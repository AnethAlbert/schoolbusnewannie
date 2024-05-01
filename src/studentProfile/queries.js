
/*************gurdian**********/
 const addStudent = "INSERT INTO student(station_id,class_id,registration_number,fname, lname, age, profilepicture, digitalfingerprint) VALUES (?,?,?,?,?,?,?,?)";
 const checkregistration_numberExists = "SELECT registration_number FROM student WHERE registration_number = ?";
 const getAllstudent = "SELECT * FROM student";
 const getStudentById = "SELECT * FROM student WHERE id =?";
 const removeStudentById= "DELETE FROM student WHERE id=?";
 const updateStudentById= "UPDATE student SET fname = ? WHERE id = ?";



module.exports={
    addStudent,
    checkregistration_numberExists,
    getAllstudent,
    getStudentById,
    removeStudentById,
    updateStudentById
}