import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quiver/time.dart';

class attandance_report extends StatefulWidget {
  int len;
  List employee;
  String name;
  String presents;
  // String time;
  attandance_report(
      {required this.name,
        /* required this.time,*/ required this.employee,
        required this.len,
        required this.presents,
        super.key});

  @override
  State<attandance_report> createState() => _attandance_reportState();

}

class _attandance_reportState extends State<attandance_report> {


 /* static DateTime checkInTime = DateTime.now().subtract(Duration(hours: 198));
  static DateTime checkOutTime = DateTime.now();

  static var hours =checkOutTime.difference(checkInTime).inHours;
  static var minutes =checkOutTime.difference(checkInTime).inMinutes;


  final totalWorkingHours = '$hours.${(minutes - (hours*60))} hrs';*/

  /*static DateTime checkInTime = DateTime.now().subtract(Duration(hours: 198,minutes: 0));
  static DateTime checkOutTime = DateTime.now();

  static var hours = checkOutTime.difference(checkInTime).inHours;
  static var minutes= checkOutTime.difference(checkInTime).inMinutes;
  var totalWorkingHours = "$hours.${(minutes - (hours*60))}";*/

  /*List <DateTime>totalWorkingHours = [];


  checkAttandace(){
    DateTime userPickedDate = DateTime.now();
    for(var i = 0; i < 22; i++)
    {
      if(userPickedDate.add(Duration(days:1)).weekday <= 5) //1 for Monday, 2 for Tuesday so checking 5 for Friday
          {
        totalWorkingHours.add(userPickedDate.add(Duration(days:1)));
      }
    }

  }*/

  //final presents = FirebaseFirestore.instance("attandace").
  /*static DateTime date  = DateTime.now();
  static DateTime days = DateTime(date.year, date.month + 1, 0).day;
  var totaldays =  days.subtract(const Duration(days: 8));*/
  //static DateTime now = DateTime.now();
  //static final days = daysInMonth(now.year, now.month);
  //final totaldays = days - 8;
  static DateTime now = DateTime.now();
  static DateTime date1 = DateTime(now.year, now.month, 1 );
  static DateTime date2 = DateTime(now.year, now.month+1, 0);

  int getDifferenceWithoutWeekends(DateTime startDate, DateTime endDate) {
    int nbDays = 0;
    DateTime currentDay = startDate;
    while (currentDay.isBefore(endDate)) {
      currentDay = currentDay.add(Duration(days: 1));
      if (currentDay.weekday != DateTime.saturday && currentDay.weekday != DateTime.sunday) {
        nbDays += 1;
      }
    }

    return nbDays;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(widget.name.toString()),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios)),

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: Get.width,
              height: Get.height * 0.1,
              // color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: Get.width * 0.30,
                    color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${widget.presents.toString()}",
                        //  totalWorkingHours.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              ),
                        ),
                        Container(
                          child: Text(
                            "presents",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width * 0.30,
                    color: Colors.orange,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${getDifferenceWithoutWeekends(date1, date2)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        Container(
                          child: Text(
                            "total days",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          /*Container(
            width: Get.width,
            height: 100,
            child: Row(
              children: [
                IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios)),
              Text(widget.employee[index]["name"].toString()
              ],
            ),
          ),*/
          Expanded(
            child: ListView.builder(
              itemCount: widget.len,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      title: Text(
                         "Date & Time : ${ widget.employee[index]["time"].toDate().toString()}"),
                      subtitle: Text("Status : ${widget.employee[index]["status"]}"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      /* body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("attandance")
          .doc(widget.id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final data = snapshot.data!.data();
        return ListView.builder(
          itemCount: data!.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              child: ListTile(
                title: Text(data[index]["name"].toString()),
                subtitle: Text(data[index]["time"].toDate().toString()),
              ),
            );
          },
        );
      },
    )*/
    );
  }
}
