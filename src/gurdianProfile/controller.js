// Import database pool and queries
const pool = require('../../db');
const bodyParser = require('body-parser');
const queries = require('./queries');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
dotenv.config();



const addgurdian = (req, res) => {
  const { fname, lname, email, phone, profilepicture, digitalfingerprint, role, password } = req.body;

  pool.query(queries.checkEmailExists, [email], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    if (results.length) {
      res.status(400).json({ error: 'Guardian already exists' });
      return;
    }

    // Assuming you have a secret key for signing the token
    const secretKey = process.env.JWT_SECRET;

    // Create a payload with user information
    const payload = {
      email: email,
      role: role,
    };

    // Sign the token with the secret key
    const token = jwt.sign(payload, secretKey, { expiresIn: '1h' }); // You can adjust the expiration time

    // First, execute the INSERT query with placeholders
    pool.query(queries.addgurdian, [fname, lname, email, phone, profilepicture, digitalfingerprint, role, password], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }

      // Now, fetch the ID of the inserted row based on the email
      pool.query('SELECT id FROM gurdian WHERE email = ?', [email], (error, results) => {
        if (error) {
          console.error(error);
          res.status(500).json({ error: 'Internal server error' });
          return;
        }

        // Assuming the query returns a single row
        if (results.length === 1) {
          const insertedId = results[0].id;

          const userInformation = {
            id: insertedId,
            email: email,
            fname: fname,
            lname: lname,
            phone: phone,
            digitalfingerprint: digitalfingerprint,
            role: role,
            // Add any other user information you want to include
          };

          res.status(201).json({
            message: 'Guardian created successfully',
            user: userInformation,
            token: token,
          });

          console.log(`Guardian ${email} created successfully`);
        } else {
          res.status(500).json({ error: 'Failed to retrieve inserted ID' });
        }
      });
    });
  });
};



//Get all Gardian
const getAllgurdian = (req, res) => {
  pool.query(queries.getAllGardian, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results);
    console.log('Retrieved all gurdians');
  });
};

//Get Gardian by id
const getgurdianById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getGardianById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    console.log(results);
    if (results=== 0) {  // Check if the array is empty
      res.status(404).json({ error: 'Gardian not found' });
      return;
    }
    res.status(200).json(results);
    console.log(`Retrieved Gardian with id: ${id}`);
  });
};



// Remove Gardian by id
const removegurdianById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getGardianById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (!results) {
      res.status(404).json({ error: 'User not found' });
      return;
    }
    pool.query(queries.removegurdianById, [id], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(200).json({ message: 'Gardian deleted successfully' });
      console.log(`Gardian with id: ${id} deleted successfully`);
    });
  });
};

// Update Gardian by id

const updategurdianById = (req, res) => {
        const id = parseInt(req.params.id);
        const {phone} = req.body;
      
        // validate input
        if ( !phone ) {
          res.status(400).send("Please provide a name for the Gardian");
          return;
        }
      
        pool.query(
          queries.getGardianById,
          [id],
          (error, results) => {
            if (error) {
              console.error(error);
              res.status(500).send("Error fetching Gardian from database");
              return;
            }
      
            const noUserFound = !results.length;
            if (noUserFound) {
              res.status(404).send("Gardian not found in the database");
              return;
            }
      
            // update Gardian name in the database
            pool.query(
                queries.updategurdianById,
              [phone, id],
              (error, results) => {
                if (error) {
                  console.error(error);
                  res.status(500).send("Error updating Gardian in database");
                  return;
                }
      
                res.status(200).send("gurdian updated successfully");
                console.log("gurdian updated successfully!");
              }
            );
          }
        );
      };

      //GET GURDIAN PROFILEPICTURE
      const getGurdianProfilePictureById = (req, res) => {
        const { id } = req.params;
      
        pool.query('SELECT profilepicture FROM gurdian WHERE id = ?', [id], (error, results) => {
          if (error) {
            console.error(error);
            res.status(500).json({ error: 'Internal server error' });
            return;
          }
      
          if (results.length === 0) {
            res.status(404).json({ error: 'Gurdian not found' });
            return;
          }
      
          const profilepicture = results[0].profilepicture;
          console.log(`Profile picture for gurdian with ID ${id}: ${profilepicture}`); // Adding console.log
          res.status(200).json({ profilepicture });
        });
      };
      
      
      // const getGurdianProfilePictureById = (req, res) => {
      //   const { id } = req.params;
      
      //   pool.query.getProfilePictureById, [id], (error, results) => {
      //     if (error) {
      //       console.error(error);
      //       res.status(500).json({ error: 'Internal server error' });
      //       return;
      //     }
      
      //     if (results.length === 0) {
      //       res.status(404).json({ error: 'Gurdian not found' });
      //       return;
      //     }
      
      //     const profilepicture = results[0].profilepicture;
      //     res.status(200).json({ profilepicture });
      //   })
      // };

      module.exports = {
        addgurdian, 
        getAllgurdian,
        getgurdianById,
        removegurdianById,
        updategurdianById,
        getGurdianProfilePictureById
      };
