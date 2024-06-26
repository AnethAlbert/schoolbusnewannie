// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');



const addpsr = (req, res) => {
  const {parent_id,student_id} = req.body;
    pool.query(queries.addPsr, [parent_id,student_id], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(201).json({ message: 'relation created successfully' });
     // console.log(`relation created successfully`);
    });
};


// //Get all student
// const getallclass = (req, res) => {
//   pool.query(queries.getAllClass, (error, results) => {
//     if (error) {
//       console.error(error);
//       res.status(500).json({ error: 'Internal server error' });
//       return;
//     }
//     res.status(200).json(results);
//     console.log('Retrieved all clases');
//   });
// };

//Get student by parent
const getpsrByparent_id = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getpsrByParent_id, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (results.length === 0) {
      res.status(404).json({ error: 'Parent-student relations not found' });
      return;
    }
    const students = results; // Assuming you need all students related to the parent
    res.status(200).json(students);
    console.log(`Retrieved ${students.length} students related to parent with id: ${id}`);
  });
};




// Remove parentStudentRelation by id
const removeParentStudentRelationById = (req, res) => {
  const parentId = parseInt(req.params.parent_id);
  const studentId = parseInt(req.params.student_id);
  
    pool.query(queries.deleteParentStudentRelation, [parentId, studentId], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({success: false, message: 'Internal server error' });
        return;
      }

      if (results.affectedRows === 0) {
        res.status(404).json({ success: false, message: 'relation not found' });
        return;
      }

      res.status(200).json({success: true, message: 'relation deleted successfully' });
      console.log(`Deleted record with parent_id: ${parentId} and student_id: ${studentId}`);

    });
};

// // Update Gardian by id

// const updateclassById = (req, res) => {
//         const id = parseInt(req.params.id);
//         const {capacity } = req.body;
      
//         // validate input
//         if (!capacity) {
//           res.status(400).send("Please provide a capasity for the class");
//           return;
//         }
      
//         pool.query(
//           queries.getClassById,
//           [id],
//           (error, results) => {
//             if (error) {
//               console.error(error);
//               res.status(500).send("Error fetching class from database");
//               return;
//             }
      
//             const noClassFound = !results.length;
//             if (noClassFound) {
//               res.status(404).send("class not found in the database");
//               return;
//             }
      
//             // update student name in the database
//             pool.query(
//                 queries.updateClassById,
//               [capacity, id],
//               (error, results) => {
//                 if (error) {
//                   console.error(error);
//                   res.status(500).send("Error updating class in database");
//                   return;
//                 }
      
//                 res.status(200).send("class updated successfully");
//                 console.log("class updated successfully!");
//               }
//             );
//           }
//         );
//       };

      module.exports = {
        addpsr, 
        // getallclass,
        getpsrByparent_id,
        removeParentStudentRelationById
        // removeclassById,
        // updateclassById
      };
