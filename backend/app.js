const express = require('express');
const Attendance = require('./routes/attendance');
const app = express();
const mongoose  = require('mongoose');
const bodyParser = require('body-parser');


mongoose.connect('mongodb+srv://fahad2001:fahad2001@cluster0.gddnrml.mongodb.net/?retryWrites=true&w=majority');

app.use('/attendance',Attendance);




app.use(express.json());
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());


app.use('/',(req,res,next)=>{
    res.status(200).json({
        message :"app is runing"
    })
});



app.use((req,res)=>{
    res.status(404).json({
        error:"Url Not Found"
    })
})

mongoose.connection.on('error',err=>{
    console.log('error');
})

mongoose.connection.on('connected',connected=>{
    console.log('connected ');
})

app.use((req,res)=>{
    res.status(404).json({
        error:"Url Not Found"
    })
})


module.exports = app;