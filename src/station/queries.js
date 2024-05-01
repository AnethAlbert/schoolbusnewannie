
/*************station**********/
 const addStation = "INSERT INTO station(code,name) VALUES (?,?)";
 const checkCodeExists = "SELECT code FROM station WHERE code = ?";
 const getallStation = "SELECT * FROM station";
 const getStationById = "SELECT * FROM station WHERE id =?";
 const removeStationById= "DELETE FROM station WHERE id=?";
 const updateStationById= "UPDATE station SET name = ? WHERE id = ?";



module.exports={
    addStation,
    checkCodeExists,
    getallStation,
    getStationById,
    removeStationById,
    updateStationById
}