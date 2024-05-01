
/*************route**********/
 const addRoute = "INSERT INTO route(code,name) VALUES (?,?)";
 const checkCodeExists = "SELECT code FROM route WHERE code = ?";
 const getallRoute = "SELECT * FROM route";
 const getRouteById = "SELECT * FROM route WHERE id =?";
 const removeRouteById= "DELETE FROM route WHERE id=?";
 const updateRouteById= "UPDATE route SET name = ? WHERE id = ?";



module.exports={
    addRoute,
    checkCodeExists,
    getallRoute,
    getRouteById,
    removeRouteById,
    updateRouteById
}