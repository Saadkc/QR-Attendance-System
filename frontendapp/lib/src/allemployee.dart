// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/get_core.dart';
// import 'package:get/get_navigation/get_navigation.dart';

// import 'package:officeproject/src/employeedata.dart';

// class allEmployeeScreen extends StatefulWidget {
//   const allEmployeeScreen({super.key});

//   @override
//   State<allEmployeeScreen> createState() => _allEmployeeScreenState();
// }

// class _allEmployeeScreenState extends State<allEmployeeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("All Employees"),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(CupertinoIcons.backward),
//         ),
//       ),
//       body: StreamBuilder(
//         stream:
//         // FirebaseFirestore.instance.collection("AllEmployee").snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             Get.snackbar("Error", "Something went wrong",
//                 snackPosition: SnackPosition.BOTTOM);
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           var data = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => employyedataScareen(
//                                 pic: data[index]["image"],
//                                 id: data[index].id,
//                                 first_name: data[index]["first_name"],
//                                 last_name: data[index]["last_name"],
//                                 age: data[index]["age"],
//                                 designation: data[index]["designation"],
//                                 joining_date:
//                                 data[index]["joining_date"].toString(),
//                                 qualification: data[index]["qualification"],
//                                 shift_time: data[index]["shift_time"])));
//                   },
//                   child: Card(
//                  //   color: Colors.cyan,
//                     child: Container(
//                       width: Get.width,
//                       height: Get.height * 0.1,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               // backgroundImage:
//                               // NetworkImage(data[index]["image"].toString())
//                               backgroundImage:
//                               NetworkImage(data[index]["image"].toString()),
//                               radius: 30,
//                               backgroundColor: Colors.blue,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   data[index]["first_name"] +
//                                       data[index]["last_name"],
//                                   //"Fahad",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                                 Text(
//                                   data[index]["designation"],
//                                   //  "Ali",
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     /*  child: ListTile(
//                       title: Text(
//                         data[index]["first_name"] + data[index]["last_name"],
//                         //"Fahad",
//                         style: TextStyle(
//                           fontSize: 20,
//                         ),
//                       ),
//                       subtitle: Text(
//                         data[index]["designation"],
//                         //  "Ali",
//                         style: TextStyle(
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),*/
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
