const { Router } = require('express');
const controller = require('./controller');

const router = Router();



/*********station********** */
router.post('/', controller.addtrip);
router.put('/:id', controller.updatetripById);
router.get('/', controller.getalltripRecords);
router.get('/:id', controller.gettripRecordById);
// router.put('/:id', controller.updatetripById);

module.exports = router;
