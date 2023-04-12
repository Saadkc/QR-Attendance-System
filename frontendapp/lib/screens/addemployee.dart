import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class addNewEmployee extends StatefulWidget {
  String uid;
  addNewEmployee({required this.uid,super.key});

  @override
  State<addNewEmployee> createState() => _addNewEmployeeState();
}

class _addNewEmployeeState extends State<addNewEmployee> {
  TextEditingController emp_id = TextEditingController();
  TextEditingController _first_name = TextEditingController();
  TextEditingController _last_name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _designation = TextEditingController();
  TextEditingController _joining_date = TextEditingController();
  TextEditingController _qualification = TextEditingController();
  TextEditingController _shift_time = TextEditingController();
  File? imagefile;
  void getimage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      File convertedfile = File(file!.path);
      setState(() {
        imagefile = convertedfile;
      });
    }
  }

  addEmployee(
      String first_name,
      String last_name,
      String age,
      String designation,
      String joiningdate,
      String qualification,
      String shift_time,
      File imagefile,
      String id,
      String _empId
      ) async {
    // final _db = FirebaseFirestore.instance;

    String first_name = _first_name.text;
    String last_name = _last_name.text;
    String age = _age.text.trim();
    String _empId = emp_id.text.trim();
    String joiningdate = _joining_date.text;
    String manager = _designation.text;
    String qualification = _qualification.text.trim();
    String shift_time = _shift_time.text.trim();
    File _imagefile = imagefile;
    try {
      if (first_name == "" ||
          last_name == "" ||
          age == "" ||
          designation == "" ||
          manager == "" ||
          shift_time == "" ||
          joiningdate == null ||
          imagefile == null||_empId == null) {
        Get.snackbar("Error", "Add all requirements",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red
        );
      } else {
        // var snapshot = await FirebaseStorage.instance
        //     .ref()
        //     .child("pictures")
        //     .child(Uuid().v1())
        //     .putFile(_imagefile);
        //TaskSnapshot taskSnapshot =await  UploadTask;
        // String downloadurl = await snapshot.ref.getDownloadURL();
//adding data here
        // _db
        //     .collection("AllEmployee").doc(id)
        //     .set({
        //   "first_name": first_name,
        //   "last_name": last_name,
        //   "age": age,
        //   "designation": designation,
        //   "manager": manager,
        //   "shift_time": shift_time,
        //   "joining_date": joiningdate,
        //   // "image": downloadurl,
        //   "employee_id":_empId
        // })
        //     .then((value) => Get.snackbar("", "Employee Added",
        //     backgroundColor: Colors.blue,
        //     snackPosition: SnackPosition.BOTTOM),

        // )

        //     .catchError((e) {
        //   Get.snackbar("Error", e.toString(),
        //       backgroundColor: Colors.redAccent,
        //       snackPosition: SnackPosition.BOTTOM);
        // });
        setState(() {
          imagefile == null;
        });
      }
    } catch (e) {
      Get.snackbar("error", e.toString(),
      snackPosition: SnackPosition.BOTTOM);
    }
  }

  void cleardata() {
    _first_name.clear();
    _last_name.clear();
    _age.clear();
    _qualification.clear();
    _shift_time.clear();
    _joining_date.clear();
    _designation.clear();
    emp_id.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee  "),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(CupertinoIcons.backward)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              (imagefile == null)
                  ? Padding(
                padding: const EdgeInsets.only(top: 15),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.cyanAccent,
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(top: 15),
                child: CircleAvatar(
                  backgroundImage: FileImage(imagefile!),
                  radius: 50,
                  backgroundColor: Colors.cyanAccent,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {
                                  getimage(source: ImageSource.camera);
                                },
                                icon: Icon(
                                  CupertinoIcons.camera,
                                  color: Colors.blue,
                                  size: 40,
                                )),
                            IconButton(
                                onPressed: () {
                                  getimage(source: ImageSource.gallery);
                                },
                                icon: Icon(
                                  CupertinoIcons.photo,
                                  color: Colors.blue,
                                  size: 40,
                                )),
                          ],
                        ));
                  },
                  icon: Icon(
                    CupertinoIcons.camera,
                    color: Colors.cyan,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(children: [
                    SizedBox(
                      width: Get.width,
                      child: TextField(
                        controller: emp_id,
                        decoration: InputDecoration(
                            hintText: "Employee ID",
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      width: Get.width,
                      child: TextField(
                        controller: _first_name,
                        decoration: InputDecoration(
                            hintText: "First Name",
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _last_name,
                      decoration: InputDecoration(
                          hintText: "Last Name", border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _age,
                      decoration: InputDecoration(
                          hintText: "Age", border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _qualification,
                      decoration: InputDecoration(
                          hintText: "Manager",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _designation,
                      decoration: InputDecoration(
                          hintText: "Designation",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _shift_time,
                      decoration: InputDecoration(
                          hintText: "Shift Time", border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _joining_date,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2050));
                        if (pickedDate != null) {
                          setState(() {
                            _joining_date.text = pickedDate.toString();
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Joining Date",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoButton(
                        color: Colors.blue,
                        child: Text("Add Employee"),
                        onPressed: () {
                          addEmployee(
                              _first_name.text,
                              _last_name.text,
                              _age.text,
                              _designation.text,
                              _joining_date.text,
                              _qualification.text,
                              _shift_time.text,
                              imagefile!,
                            widget.uid,
                            emp_id.text
                          );
                          cleardata();
                        })
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
