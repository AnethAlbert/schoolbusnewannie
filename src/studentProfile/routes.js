const { Router } = require('express');
const controller = require('./controller');

const router = Router();



/*********student********** */
router.post('/', controller.addstudent);
router.get('/', controller.getallstudent);
router.get('/:id', controller.getstudentById);
router.delete('/:id', controller.removestudentById);
router.put('/:id', controller.updatestudentById);

module.exports = router;
