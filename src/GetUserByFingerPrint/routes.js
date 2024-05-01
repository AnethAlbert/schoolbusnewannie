const { Router } = require('express');
const controller = require('./controller');

const router = Router();



// Handle POST request to Retreave fingerprint data
router.post('/', controller.GetFingerPrint);

module.exports = router;
