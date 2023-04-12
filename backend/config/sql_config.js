const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'rootuser',
  database: 'tp_attandence'
});
connection.connect((err) => {
  if (err) throw err;
  console.log('Connected!');
});


module.exports = connection;