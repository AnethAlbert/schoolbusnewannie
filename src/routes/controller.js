// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');



const addroute = (req, res) => {
  const { code,name} = req.body;
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
    pool.query(queries.addRoute, [code,name], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(201).json({ message: 'route created successfully' });
      console.log(`route ${name} created successfully`);
    });
  });
};


//Get all student
const getallroute = (req, res) => {
  pool.query(queries.getallRoute, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results);
    console.log('Retrieved all routes');
  });
};

//Get route by id
const getrouteById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getRouteById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    console.log(results);
    if (results=== 0) {  // Check if the array is empty
      res.status(404).json({ error: 'route not found' });
      return;
    }
    res.status(200).json(results);
    console.log(`Retrieved route with id: ${id}`);
  });
};



// Remove route by id
const removerouteById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getRouteById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (!results.length) {
      res.status(404).json({ error: 'route not found' });
      return;
    }
    pool.query(queries.removeRouteById, [id], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(200).json({ message: 'route deleted successfully' });
      console.log(`route with id: ${id} deleted successfully`);
    });
  });
};

// Update Gardian by id

const updaterouteById = (req, res) => {
        const id = parseInt(req.params.id);
        const {name } = req.body;
      
        // validate input
        if (!name) {
          res.status(400).send("Please provide a name for the route");
          return;
        }
      
        pool.query(
          queries.getRouteById,
          [id],
          (error, results) => {
            if (error) {
              console.error(error);
              res.status(500).send("Error fetching route from database");
              return;
            }
      
            const noRouteFound = !results.length;
            if (noRouteFound) {
              res.status(404).send("route not found in the database");
              return;
            }
      
            // update route name in the database
            pool.query(
                queries.updateRouteById,
              [name, id],
              (error, results) => {
                if (error) {
                  console.error(error);
                  res.status(500).send("Error updating route in database");
                  return;
                }
      
                res.status(200).send("route updated successfully");
                console.log("route updated successfully!");
              }
            );
          }
        );
      };

      module.exports = {
        addroute, 
        getallroute,
        getrouteById,
        removerouteById,
        updaterouteById
      };
