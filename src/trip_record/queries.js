
/*************trip_record**********/
 const addTrip = "INSERT INTO trip_record(routeid,gurdianid,description,weekof) VALUES (?,?,?,?)";
 const GetalltripRecords = "SELECT * FROM trip_record";
 const GettripRecordById = "SELECT * FROM trip_record WHERE id =?";
//  const GettripRecordById= "DELETE FROM trip_record WHERE id=?";
 const updateTripById= "UPDATE trip_record SET gurdianid = ? WHERE id = ?";



module.exports={
    addTrip,
    GetalltripRecords,
   // getTripById,
    GettripRecordById,
    updateTripById
}