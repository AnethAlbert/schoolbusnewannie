const { Router } = require('express');
const controller = require('./controller');

const router = Router();

/*********send message to parents********** */
router.post('/', controller.sendMessageToParents);

module.exports = router;