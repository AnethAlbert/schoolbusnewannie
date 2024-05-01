
/*************gurdian**********/
 const addparent = "INSERT INTO parent(fname , lname , email, phone ,profilepicture ,password) VALUES (?,?,?,?,?,?)";
 const checkEmailExists = "SELECT email FROM parent WHERE email = ?";
 const getAllparent = "SELECT * FROM parent";
 const getParentById = "SELECT * FROM parent WHERE id =?";
 const removeParentById= "DELETE FROM parent WHERE id=?";
 const updateParentById= "UPDATE parent SET phone = ? WHERE id = ?";



module.exports={
    addparent,
    checkEmailExists,
    getAllparent,
    getParentById,
    removeParentById,
    updateParentById
}