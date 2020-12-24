import 'package:data_modeling/model/dataModels.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Student s1 = Student("18301115", [], "Imran", "01703180525", "adasd", "B+",
  //     "015465351", "CSE");

  List<Student> studentCollection = [];

  String id,
      name,
      phoneNumber,
      address,
      bloodGroup,
      emergencyNumber,
      department;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Student s1 = Student(id, [], name, phoneNumber, address, bloodGroup,
                emergencyNumber, department);

            setState(() {
              studentCollection.add(s1);
            });
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Student Information",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              !studentCollection.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: studentCollection.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.grey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    studentCollection[index].name,
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    studentCollection[index].department,
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    studentCollection[index].id,
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    studentCollection[index].bloodGroup,
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    studentCollection[index].phoneNumber,
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Text("No student record is available"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (v) {
                        id = v;
                      },
                      decoration: InputDecoration(
                        hintText: "Student Id",
                      ),
                    ),
                    TextField(
                      onChanged: (v) {
                        name = v;
                      },
                      decoration: InputDecoration(
                        hintText: "Student Name",
                      ),
                    ),
                    TextField(
                      onChanged: (v) {
                        phoneNumber = v;
                      },
                      decoration: InputDecoration(
                        hintText: "Student Phone Number",
                      ),
                    ),
                    TextField(
                      onChanged: (v) {
                        bloodGroup = v;
                      },
                      decoration: InputDecoration(
                        hintText: "Student Blood Group",
                      ),
                    ),
                    TextField(
                      onChanged: (v) {
                        address = v;
                      },
                      decoration: InputDecoration(
                        hintText: "Student Address",
                      ),
                    ),
                    TextField(
                      onChanged: (v) {
                        department = v;
                      },
                      decoration: InputDecoration(
                        hintText: "Student Department",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
