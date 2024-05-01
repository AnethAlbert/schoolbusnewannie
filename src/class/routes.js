const { Router } = require('express');
const controller = require('./controller');

const router = Router();



/*********class********** */
router.post('/', controller.addclass);
router.get('/', controller.getallclass);
router.get('/:id', controller.getclassById);
router.delete('/:id', controller.removeclassById);
router.put('/:id', controller.updateclassById);

module.exports = router;
