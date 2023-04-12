const express = require('express');
const router = express.Router()
const connection = require('../config/sql_config');
const util = require('util');

var dbQuery;

dbQuery = util.promisify(connection.query).bind(connection);

router.post('/scan', async (req, res) => {

    const name = req.body.name;
    const status = req.body.status;
    const break_time = req.body.break_time;
    const break_timeoff = req.body.break_timeoff;

    if(status === "Log In"){
        const result = dbQuery(`INSERT INTO attendance (login_time, name, status) VALUES (CURRENT_TIMESTAMP,?,?)`, [name, status])
        res.status(200).json({"status": "success", "message": "Attendance added successfully"});

    } else if(status === "Log Out"){
        const result = dbQuery(`UPDATE attendance SET logout_time=CURRENT_TIMESTAMP, status="Log Out" WHERE name='${name}'`);
        res.status(200).json({"status": "success", "message": "Attendance Updated successfully"});

    } else {
        if(break_time == null){
            const result = dbQuery(`UPDATE attendance SET (breakoff_time=${break_timeoff}, status=${status}) WHERE name=${name}`)
            res.status(200).json({"status": "success", "message": "Attendance Updated successfully"});
        }else{
            const result = dbQuery(`UPDATE attendance SET (break_time=${break_time}, status=${status}) WHERE name=${name}`)
            res.status(200).json({"status": "success", "message": "Attendance Updated successfully"});
        }
    }

});

module.exports = router