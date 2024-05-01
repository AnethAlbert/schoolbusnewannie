const { Router } = require('express');
const controller = require('./controller');

const router = Router();



/*********routes********** */
router.post('/', controller.addroute);
router.get('/', controller.getallroute);
router.get('/:id', controller.getrouteById);
router.delete('/:id', controller.removerouteById);
router.put('/:id', controller.updaterouteById);

module.exports = router;
