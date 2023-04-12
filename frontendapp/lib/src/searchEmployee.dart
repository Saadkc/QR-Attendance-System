
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:officeproject/src/attandacereport.dart';


class searchEmployee extends StatefulWidget {
  const searchEmployee({super.key});

  @override
  State<searchEmployee> createState() => _searchEmployeeState();
}

class _searchEmployeeState extends State<searchEmployee> {
  List search = [];
  List emloyee = [];
  var ep;
  TextEditingController _query = TextEditingController();
  void searchFromFirebase(String query) async {
    /*final result = await FirebaseFirestore.instance
        .collection("attandance")
        .where(
          "name",
          isEqualTo: query,
        )
        .get();*/
    _query == query.trim();
    // final result = await FirebaseFirestore.instance
    //     .collection('attandance')
    //     .orderBy("id")
    //     .startAt([query]).endAt([query + '\uf8ff']).get();
    // setState(() {
    //   search = result.docs.map((e) => e.data()).toList();
    //   emloyee.add(search);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: TextField(
                controller: _query,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Search Employee",
                    suffixIcon: Icon(
                      CupertinoIcons.search,
                      color: Colors.black,
                    )),
                onChanged: ((value) {
                  if (value != null) {
                    searchFromFirebase(value);
                  } /*else if (value == null) {
                    setState(() {
                      con();
                    });
                  }*/
                }),
              ),
            ),
            /*(_query == null)
                ? Container(

                  )
                :*/
            Expanded(
                child: ListView.builder(
                  itemCount: search.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => attandance_report(
                                  len: search.length, employee: search,
                                  presents: search[index]["presnts"].toString(),
                                  name: search[index]["id"],

                                  // time: search[index]["time"]
                                  //  .toDate()
                                  //  .toString()))
                                )));
                      }),
                      child: ListTile(
                        title: Text(" ${search[index]["id"]}"),
                        subtitle: Column(
                          children: [
                            // search[index]["time"])
                            //Text(DateTime.parse(search[index]["time"]).toString())
                            Text(search[index]["time"].toDate().toString())
                          ],
                        ),
                      ),
                    );
                  },
                ))
            /* Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("attandance")
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
                  var data = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      attandance_report(id: data[index].id)));
                        },
                        child: Card(
                            elevation: 10,
                            child: ListTile(
                              title: Text(" ${search[index]["name"]}"),
                              subtitle: Column(
                                children: [
                                  // search[index]["time"])
                                  //Text(DateTime.parse(search[index]["time"]).toString())
                                  Text(
                                      search[index]["time"].toDate().toString())
                                ],
                              ),
                            )),
                      );
                    },
                  );
                },
              ),
            )*/
            /**/
          ],
        ),
      ),
    );
  }

  Widget con() {
    return Expanded(
        child: Center(
          child: Container(
            child: Text("Search employee"),
          ),
        ));
  }
}
