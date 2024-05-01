const { Router } = require('express');
const controller = require('./controller');

const router = Router();



/*********gurdian********** */
router.post('/', controller.addgurdian);
router.get('/', controller.getAllgurdian);
router.get('/:id', controller.getgurdianById);
router.delete('/:id', controller.removegurdianById);
router.put('/:id', controller.updategurdianById);
router.get('/:id/profilepicture', controller.getGurdianProfilePictureById);

module.exports = router;
