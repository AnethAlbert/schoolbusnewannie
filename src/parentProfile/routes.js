const { Router } = require('express');
const controller = require('./controller');

const router = Router();



/*********parent********** */
router.post('/', controller.addparent);
router.get('/', controller.getAllparent);
router.get('/:id', controller.getparentById);
router.delete('/:id', controller.removeparentById);
router.put('/:id', controller.updateparentById);

module.exports = router;
