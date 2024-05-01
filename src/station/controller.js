// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');



const addstation = (req, res) => {
  const {code,name} = req.body;
  pool.query(queries.checkCodeExists, [code], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (results.length) {
      res.status(400).json({ error: 'code already exists' });
      return;
    }
    pool.query(queries.addStation, [code,name], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(201).json({ message: 'station created successfully' });
      console.log(`statio ${name} created successfully`);
      console.log(`statio ${code} created successfully`);
    });
  });
};


//Get all station
const getallstation = (req, res) => {
  pool.query(queries.getallStation, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results);
    console.log('Retrieved all stations');
  });
};

//Get station by id
const getstationById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getStationById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    console.log(results);
    if (results=== 0) {  // Check if the array is empty
      res.status(404).json({ error: 'station not found' });
      return;
    }
    res.status(200).json(results);
    console.log(`Retrieved station with id: ${id}`);
  });
};



// Remove station by id
const removestationById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getStationById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (!results.length) {
      res.status(404).json({ error: 'station not found' });
      return;
    }
    pool.query(queries.removeStationById, [id], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(200).json({ message: 'station deleted successfully' });
      console.log(`station with id: ${id} deleted successfully`);
    });
  });
};

// Update station by id

const updatestationById = (req, res) => {
        const id = parseInt(req.params.id);
        const {name } = req.body;
      
        // validate input
        if (!name) {
          res.status(400).send("Please provide a name for the station");
          return;
        }
      
        pool.query(
          queries.getStationById,
          [id],
          (error, results) => {
            if (error) {
              console.error(error);
              res.status(500).send("Error fetching station from database");
              return;
            }
      
            const noStationFound = !results.length;
            if (noStationFound) {
              res.status(404).send("station not found in the database");
              return;
            }
      
            // update station name in the database
            pool.query(
                queries.updateStationById,
              [name, id],
              (error, results) => {
                if (error) {
                  console.error(error);
                  res.status(500).send("Error updating station in database");
                  return;
                }
      
                res.status(200).send("station updated successfully");
                console.log("station updated successfully!");
              }
            );
          }
        );
      };

      module.exports = {
        addstation, 
        getallstation,
        getstationById,
        removestationById,
        updatestationById
      };
