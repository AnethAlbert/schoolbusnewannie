
/*************bus**********/
 const addBus = "INSERT INTO bus(registration_number,model,capacity) VALUES (?,?,?)";
 const checkregistration_numberExists = "SELECT registration_number FROM bus WHERE registration_number = ?";
//  const getAllClass = "SELECT * FROM bus";
//  const getClassById = "SELECT * FROM bus WHERE id =?";
//  const removeClassById= "DELETE FROM bus WHERE id=?";
//  const updateClassById= "UPDATE bus SET capacity = ? WHERE id = ?";



module.exports={
    addBus,
    checkregistration_numberExists,
    // getAllClass,
    // getClassById,
    // removeClassById,
    // updateClassById
}