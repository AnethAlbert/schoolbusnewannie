const { Router } = require('express');
const controller = require('./controller');

const router = Router();



/*********class********** */
router.post('/', controller.addbus);
// router.get('/', controller.getallbus);
// router.get('/:id', controller.getbusById);
// router.delete('/:id', controller.removebusById);
// router.put('/:id', controller.updatebusById);

module.exports = router;
