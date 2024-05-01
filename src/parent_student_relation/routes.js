const { Router } = require('express');
const controller = require('./controller');

const router = Router();



/*********parent_student_relation********** */
router.post('/', controller.addpsr);
// router.get('/', controller.getallpsr);
router.get('/:id', controller.getpsrByparent_id);
// router.delete('/:id', controller.removepsrById);
// router.put('/:id', controller.updatepsrById);

module.exports = router;
