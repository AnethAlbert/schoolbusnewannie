
/*************gurdian**********/
const addgurdian = `
INSERT INTO gurdian (fname, lname, email, phone, profilepicture, digitalfingerprint, role, password)
VALUES (?,?,?,?,?,?,?,?)
`;

 const checkEmailExists = "SELECT email FROM gurdian WHERE email = ?";
 const getAllGardian = "SELECT * FROM Gurdian";
 const getGardianById = "SELECT * FROM Gurdian WHERE id =?";
 const removegurdianById= "DELETE FROM Gurdian WHERE id=?";
 const updategurdianById= "UPDATE Gurdian SET phone = ? WHERE id = ?";
 //const getProfilePictureById= 'SELECT profilepicture FROM gurdian WHERE id = ?';



module.exports={
    addgurdian,
    checkEmailExists,
    getAllGardian,
    getGardianById,
    removegurdianById,
    updategurdianById,
  //  getProfilePictureById
}