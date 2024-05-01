const { Router } = require('express');
const controller = require('./controller');

const router = Router();



/*********station********** */
router.post('/', controller.addstation);
router.get('/', controller.getallstation);
router.get('/:id', controller.getstationById);
router.delete('/:id', controller.removestationById);
router.put('/:id', controller.updatestationById);

module.exports = router;
