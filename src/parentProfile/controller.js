// Import database pool and queries
const pool = require('../../db');
const bodyParser = require('body-parser');
const queries = require('./queries');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
dotenv.config();


const addparent = (req, res) => {
  const { fname, lname, email, phone, profilepicture, password  } = req.body;
  
  pool.query(queries.checkEmailExists, [email], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (results.row) {
      res.status(400).json({ error: 'Email already exists' });
      return;
    }
    
    const secretKey = process.env.JWT_SECRET;
    const payload = {
      email: email,
      role: 'parent', // Assuming role is fixed for parents
    };
    const token = jwt.sign(payload, secretKey, { expiresIn: '1h' });
    
    pool.query(queries.addparent, [fname, lname, email, phone, profilepicture, password], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      
      pool.query('SELECT id FROM parent WHERE email = ?', [email], (error, results) => {
        if (error) {
          console.error(error);
          res.status(500).json({ error: 'Internal server error' });
          return;
        }
        if (results.length === 1) {
          const insertedId = results[0].id;
          
          const parentInformation = {
            id: insertedId,
            email: email,
            fname: fname,
            lname: lname,
            phone: phone,
            profilepicture: profilepicture,
            // Add any other parent information you want to include
          };
          
          res.status(201).json({
            message: 'Parent created successfully',
            user: parentInformation,
            token: token,
          });
          
          console.log(`Parent ${lname} created successfully`);
        } else {
          res.status(500).json({ error: 'Failed to retrieve inserted ID' });
        }
      });
    });
  });
};



//Get all Gardian
const getAllparent = (req, res) => {
  pool.query(queries.getAllparent, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results);
    console.log('Retrieved all parents');
  });
};

//Get Gardian by id
const getparentById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getParentById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    console.log(results);
    if (results=== 0) {  // Check if the array is empty
      res.status(404).json({ error: 'Parent not found' });
      return;
    }
    res.status(200).json(results);
    console.log(`Retrieved Parent with id: ${id}`);
  });
};



// Remove Gardian by id
const removeparentById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getParentById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (!results) {
      res.status(404).json({ error: 'User not found' });
      return;
    }
    pool.query(queries.removeParentById, [id], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(200).json({ message: 'Parent deleted successfully' });
      console.log(`Parent with id: ${id} deleted successfully`);
    });
  });
};

// Update Gardian by id

const updateparentById = (req, res) => {
        const id = parseInt(req.params.id);
        const {phone } = req.body;
      
        // validate input
        if (!phone) {
          res.status(400).send("Please provide a name for the Gardian");
          return;
        }
      
        pool.query(
          queries.getParentById,
          [id],
          (error, results) => {
            if (error) {
              console.error(error);
              res.status(500).send("Error fetching Gardian from database");
              return;
            }
      
            const noUserFound = !results.length;
            if (noUserFound) {
              res.status(404).send("Parent not found in the database");
              return;
            }
      
            // update Gardian name in the database
            pool.query(
                queries.updateParentById,
              [phone, id],
              (error, results) => {
                if (error) {
                  console.error(error);
                  res.status(500).send("Error updating Gardian in database");
                  return;
                }
      
                res.status(200).send("Parent updated successfully");
                console.log("Parent updated successfully!");
              }
            );
          }
        );
      };

      module.exports = {
        addparent, 
        getAllparent,
        getparentById,
        removeparentById,
        updateparentById
      };
