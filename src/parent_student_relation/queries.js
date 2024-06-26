
/*************spR**********/
 const addPsr = "INSERT INTO parent_student_relation(parent_id,student_id) VALUES (?,?)";
//  const checkCodeExists = "SELECT code FROM class WHERE code = ?";
//  const getAllClass = "SELECT * FROM class";
 const getpsrByParent_id = "SELECT s.*  FROM student s JOIN parent_student_relation psr ON s.id = psr.student_id WHERE psr.parent_id = ?";
 const deleteParentStudentRelation = "DELETE FROM parent_student_relation WHERE parent_id = ? AND student_id = ?";
//  const removeClassById= "DELETE FROM class WHERE id=?";
//  const updateClassById= "UPDATE class SET capacity = ? WHERE id = ?";



module.exports= {
    addPsr,
    // checkCodeExists,
    // getAllClass,
    getpsrByParent_id,
    deleteParentStudentRelation
    // removeClassById,
    // updateClassById
}