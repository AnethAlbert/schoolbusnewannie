// Import database pool and queries
const pool = require('../../db');
const bodyParser = require('body-parser');
const queries = require('./queries');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
dotenv.config();

const addstudent = (req, res) => {
  const { station_id, class_id, registration_number, fname, lname, age, profilepicture, digitalfingerprint } = req.body;
  
  pool.query(queries.checkregistration_numberExists, [registration_number], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (results.length) {
      res.status(400).json({ error: 'registration_number already exists' });
      return;
    }
    
    const secretKey = process.env.JWT_SECRET;
    const payload = {
      registration_number: registration_number,
      role: 'student', // Assuming role is fixed for students
    };
    const token = jwt.sign(payload, secretKey, { expiresIn: '1h' });
    
    pool.query(queries.addStudent, [station_id, class_id, registration_number, fname, lname, age, profilepicture, digitalfingerprint], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      
      pool.query('SELECT id FROM student WHERE registration_number = ?', [registration_number], (error, results) => {
        if (error) {
          console.error(error);
          res.status(500).json({ error: 'Internal server error' });
          return;
        }
        if (results.length === 1) {
          const insertedId = results[0].id;
          
          const studentInformation = {
            id: insertedId,
            registration_number: registration_number,
            fname: fname,
            lname: lname,
            age: age,
            profilepicture: profilepicture,
            digitalfingerprint: digitalfingerprint,
            // Add any other student information you want to include
          };
          
          res.status(201).json({
            message: 'Student created successfully',
            user: studentInformation,
            token: token,
          });
          
          console.log(`Student ${lname} created successfully`);
        } else {
          res.status(500).json({ error: 'Failed to retrieve inserted ID' });
        }
      });
    });
  });
};


//Get all student
const getallstudent = (req, res) => {
  pool.query(queries.getAllstudent, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results);
    console.log('Retrieved all student');
  });
};

//Get student by id
const getstudentById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getStudentById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    console.log(results);
    if (results=== 0) {  // Check if the array is empty
      res.status(404).json({ error: 'student not found' });
      return;
    }
    res.status(200).json(results);
    console.log(`Retrieved student with id: ${id}`);
  });
};



// Remove student by id
const removestudentById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getStudentById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (!results) {
      res.status(404).json({ error: 'User not found' });
      return;
    }
    pool.query(queries.removeStudentById, [id], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(200).json({ message: 'Student deleted successfully' });
      console.log(`Student with id: ${id} deleted successfully`);
    });
  });
};

// Update Gardian by id

const updatestudentById = (req, res) => {
        const id = parseInt(req.params.id);
        const {fname } = req.body;
      
        // validate input
        if (!fname) {
          res.status(400).send("Please provide a name for the student");
          return;
        }
      
        pool.query(
          queries.getStudentById,
          [id],
          (error, results) => {
            if (error) {
              console.error(error);
              res.status(500).send("Error fetching Gardian from database");
              return;
            }
      
            const noUserFound = !results.length;
            if (noUserFound) {
              res.status(404).send("student not found in the database");
              return;
            }
      
            // update student name in the database
            pool.query(
                queries.updateStudentById,
              [fname, id],
              (error, results) => {
                if (error) {
                  console.error(error);
                  res.status(500).send("Error updating Gardian in database");
                  return;
                }
      
                res.status(200).send("student updated successfully");
                console.log("student updated successfully!");
              }
            );
          }
        );
      };

      module.exports = {
        addstudent, 
        getallstudent,
        getstudentById,
        removestudentById,
        updatestudentById
      };
