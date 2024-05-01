const { Router } = require('express');
const controller = require('./controller');

const router = Router();



/*********gurdian********** */
router.post('/', controller.addstudentTo_trip_list);
router.get('/:id', controller.getStudentIdsByTripId);
router.get('/', controller.getAllStudentIds);
// router.delete('/:id', controller.removestudentFrom_trip_listById);
// router.put('/:id', controller.updatestudentFrom_trip_listById);


module.exports = router;
