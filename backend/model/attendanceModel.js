const mongoose  = require('mongoose');

const attendanceSchema = mongoose.Schema({
    _id:mongoose.Schema.Types.ObjectId,
    employeeName : String,
    status : String,
    checkInDate : Date,
    checkOutDate: Date,
    breakCheckIn:Date,
    breakCheckOut:Date
})

module.exports = mongoose.model('Attendance',attendanceSchema);