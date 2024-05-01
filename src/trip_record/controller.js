// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');



const addtrip = (req, res) => {
  const { routeid, gurdianid, description } = req.body;
  
  // Calculate the week number within the month
  const currentDate = new Date();
  const startOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
  const diff = currentDate.getDate() + startOfMonth.getDay() - 1;
  const weekof = Math.ceil(diff / 7);

  pool.query(queries.addTrip, [routeid, gurdianid, description, weekof], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    // Get the ID of the inserted row from the results
    const insertedId = results.insertId;
    console.log(insertedId);

    // Send the ID in the response
    res.status(201).json({ message: 'trip created successfully', id: insertedId });
    console.log(`trip created successfully with ID: ${insertedId}`);
  });
};


// const addtrip = (req, res) => {
//   const { routeid, gurdianid, description, weekof } = req.body;
//   pool.query(queries.addTrip, [routeid, gurdianid, description, weekof], (error, results) => {
//     if (error) {
//       console.error(error);
//       res.status(500).json({ error: 'Internal server error' });
//       return;
//     }

//     // Get the ID of the inserted row from the results
//     const insertedId = results.insertId;
//     console.log(insertedId);

//     // Send the ID in the response
//     res.status(201).json({ message: 'trip created successfully', id: insertedId });
//     console.log(`trip created successfully with ID: ${insertedId}`);
//   });
// };



//Get all getalltripRecords
const getalltripRecords = (req, res) => {
  pool.query(queries.GetalltripRecords, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results);
    console.log('Retrieved all stations');
  });
};

//Get tripRecord by id
const gettripRecordById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.GettripRecordById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    console.log(results);
    if (results=== 0) {  // Check if the array is empty
      res.status(404).json({ error: 'record not found' });
      return;
    }
    res.status(200).json(results);
    console.log(`Retrieved record with id: ${id}`);
  });
};



// // Remove station by id
// const removestationById = (req, res) => {
//   const id = parseInt(req.params.id);
//   pool.query(queries.getStationById, [id], (error, results) => {
//     if (error) {
//       console.error(error);
//       res.status(500).json({ error: 'Internal server error' });
//       return;
//     }
//     if (!results.length) {
//       res.status(404).json({ error: 'station not found' });
//       return;
//     }
//     pool.query(queries.removeStationById, [id], (error, results) => {
//       if (error) {
//         console.error(error);
//         res.status(500).json({ error: 'Internal server error' });
//         return;
//       }
//       res.status(200).json({ message: 'station deleted successfully' });
//       console.log(`station with id: ${id} deleted successfully`);
//     });
//   });
// };

// Update trip by id

const updatetripById = (req, res) => {
        const id = parseInt(req.params.id);
        const {gurdianid } = req.body;
      
        // validate input
        if (!gurdianid) {
          res.status(400).send("Please provide a gurdianid for the trip");
          return;
        }
      
        pool.query(
          queries.GettripRecordById,
          [id],
          (error, results) => {
            if (error) {
              console.error(error);
              res.status(500).send("Error fetching trip from database");
              return;
            }
      
            const notripFound = !results.length;
            if (notripFound) {
              res.status(404).send("trip not found in the database");
              return;
            }
      
            // update trip in the database
            pool.query(
                queries.updateTripById,
              [gurdianid, id],
              (error, results) => {
                if (error) {
                  console.error(error);
                  res.status(500).send("Error updating trip in database");
                  return;
                }
      
                res.status(200).send("trip updated successfully");
                console.log("trip updated successfully!");
              }
            );
          }
        );
      };

      module.exports = {
        addtrip, 
        getalltripRecords,
        gettripRecordById,
        // removestationById,
        updatetripById
      };
