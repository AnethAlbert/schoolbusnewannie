const { Router } = require('express');
const controller = require('./controller');

const router = Router();



/*********trip************/
router.post('/', controller.addtrip);
router.put('/:id', controller.updatetripById);
router.get('/', controller.getalltripRecords);
router.get('/:id', controller.gettripRecordById);
router.get('/active/:id', controller.getActiveTripRecordByGuardianId);
router.get('/end/:id', controller.updateTripStatusById);
router.get('/students-attendance/:id', controller.getStudentsAttendance);
router.post('/drop-student', controller.updateStudentTripStatus);

module.exports = router;
 