const express = require('express');
const router = express.Router()
const connection = require('../config/sql_config');
const util = require('util');

var dbQuery;

dbQuery = util.promisify(connection.query).bind(connection);

router.get('/', (req, res) => {
    res.send('Hello World!')
});

router.post('/scan', async (req, res) => {

    const name = req.body.name;
    const status = req.body.status;
    const id = req.body.id;
    console.log(status);
    if (status === "Log In") {
        const result = await dbQuery(`INSERT INTO attendance (login_time, name, status) VALUES (CURRENT_TIMESTAMP,?,?)`, [name, status]);
        const getResult = await dbQuery(`SELECT * FROM attendance WHERE id='${result.insertId}'`);
        res.status(200).json({ "status": "success", "data": getResult });
    } else if (status === "Log Out") {
        const result = dbQuery(`UPDATE attendance SET logout_time=CURRENT_TIMESTAMP, status="Log Out" WHERE id='${id}'`);
        res.status(200).json({ "status": "success", "message": "Attendance Updated successfully" });
    } else if (status === "Break-off") {
        const result = dbQuery(`UPDATE attendance SET breakoff_time=CURRENT_TIMESTAMP, status="Break-off" WHERE id=${id}`)
        res.status(200).json({ "status": "success", "message": "Attendance Updated successfully" });
    } else {
        const result = dbQuery(`UPDATE attendance SET break_time=CURRENT_TIMESTAMP, status="Break" WHERE id=${id}`)
        res.status(200).json({ "status": "success", "message": "Attendance Updated successfully" });
    }

});

module.exports = router