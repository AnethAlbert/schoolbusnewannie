const { Router } = require('express');
const controller = require('./controller');

const router = Router();



// Handle POST request to add fingerprint data
router.post('/', controller.addFingerPrint);

module.exports = router;
