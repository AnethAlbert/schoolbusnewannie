
/*************class**********/
 const addClass = "INSERT INTO class(code,name,capacity) VALUES (?,?,?)";
 const checkCodeExists = "SELECT code FROM class WHERE code = ?";
 const getAllClass = "SELECT * FROM class";
 const getClassById = "SELECT * FROM class WHERE id =?";
 const removeClassById= "DELETE FROM class WHERE id=?";
 const updateClassById= "UPDATE class SET capacity = ? WHERE id = ?";



module.exports={
    addClass,
    checkCodeExists,
    getAllClass,
    getClassById,
    removeClassById,
    updateClassById
}