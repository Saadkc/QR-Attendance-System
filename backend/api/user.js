const express = require('express');
const router = express.Router()
const connection = require('../config/sql_config');
const util = require('util');

var dbQuery;

dbQuery = util.promisify(connection.query).bind(connection);

router.post('/login', async (req, res) => { 
    const email = req.body.email;
    const password = req.body.password;

    const user = await dbQuery(`SELECT * FROM user WHERE email='${email}' AND password='${password}'`);
    if (user) {
        res.status(200).json({ "status": "success", "data": user[0] });
    } else {
        res.status(401).json({ "status": "error", "message": "Invalid username or password" });
    }

});

module.exports = router;