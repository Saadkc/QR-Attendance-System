const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const connection = require('./config/sql_config.js');
const util = require('util');
const cors = require('cors');
const qrscan = require('./api/scan_qr.js')
const auth = require('./api/user.js');
const port = 3000;

var dbQuery;
dbQuery = util.promisify(connection.query).bind(connection);

app.use(express.json());
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
app.use(cors());

//-----------------APIs-----------------//
app.use("/api", auth);
app.use("/api", qrscan);


app.listen(port,console.log('server created'))