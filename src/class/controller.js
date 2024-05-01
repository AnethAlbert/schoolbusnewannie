// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');



const addclass = (req, res) => {
  const { code,name,capacity} = req.body;
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
    pool.query(queries.addClass, [code,name,capacity], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(201).json({ message: 'class created successfully' });
      console.log(`class ${code} created successfully`);
    });
  });
};


//Get all student
const getallclass = (req, res) => {
  pool.query(queries.getAllClass, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results);
    console.log('Retrieved all clases');
  });
};

//Get student by id
const getclassById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getClassById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    console.log(results);
    if (results=== 0) {  // Check if the array is empty
      res.status(404).json({ error: 'class not found' });
      return;
    }
    res.status(200).json(results);
    console.log(`Retrieved class with id: ${id}`);
  });
};



// Remove student by id
const removeclassById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getClassById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (!results.length) {
      res.status(404).json({ error: 'class not found' });
      return;
    }
    pool.query(queries.removeClassById, [id], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(200).json({ message: 'class deleted successfully' });
      console.log(`class with id: ${id} deleted successfully`);
    });
  });
};

// Update Gardian by id

const updateclassById = (req, res) => {
        const id = parseInt(req.params.id);
        const {capacity } = req.body;
      
        // validate input
        if (!capacity) {
          res.status(400).send("Please provide a capasity for the class");
          return;
        }
      
        pool.query(
          queries.getClassById,
          [id],
          (error, results) => {
            if (error) {
              console.error(error);
              res.status(500).send("Error fetching class from database");
              return;
            }
      
            const noClassFound = !results.length;
            if (noClassFound) {
              res.status(404).send("class not found in the database");
              return;
            }
      
            // update student name in the database
            pool.query(
                queries.updateClassById,
              [capacity, id],
              (error, results) => {
                if (error) {
                  console.error(error);
                  res.status(500).send("Error updating class in database");
                  return;
                }
      
                res.status(200).send("class updated successfully");
                console.log("class updated successfully!");
              }
            );
          }
        );
      };

      module.exports = {
        addclass, 
        getallclass,
        getclassById,
        removeclassById,
        updateclassById
      };
