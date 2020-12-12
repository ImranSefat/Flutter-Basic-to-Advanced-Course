import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Timeline extends StatefulWidget {
  final User firebaseUser;
  Timeline({this.firebaseUser});

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final _formKey = GlobalKey<FormState>();
  String title;
  String desc;
  CollectionReference taskListRef = FirebaseFirestore.instance
      .collection('taskLists')
      .doc('firestore12-12-2020')
      .collection('taskList_CRUD');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.supervised_user_circle),
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text(
              "Welcome",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  title = value;
                },
                validator: (value) {
                  if (value.length == 0) {
                    return "Please fill up";
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Title"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  desc = value;
                },
                validator: (value) {
                  if (value.length == 0) {
                    return "Please fill up";
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Description"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.green,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    addDataToFirestore(title, desc);
                  }
                },
                child: Text("Add to Database"),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: taskListRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return new ListView(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: new ListTile(
                            title: new Text(document.data()['title']),
                            subtitle: new Text(document.data()['description']),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _askToDelete(taskListRef, document);
                          },
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await _editData(taskListRef, document);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addDataToFirestore(String title, String desc) {
    CollectionReference taskListRef = FirebaseFirestore.instance
        .collection('taskLists')
        .doc('firestore12-12-2020')
        .collection('taskList_CRUD');

    taskListRef
        .add({
          'title': title,
          'description': desc,
        })
        .then(
          (value) => _showMaterialDialog("Task is added"),
        )
        .catchError(
          (error) => _showMaterialDialog(
            error.toString(),
          ),
        );
  }

  Future<void> _updateData(
      String title,
      String desc,
      CollectionReference collectionReference,
      DocumentSnapshot documentSnapshot) {
    return collectionReference.doc(documentSnapshot.id).update({
      'title': title,
      'description': desc,
    });
  }

  _showMaterialDialog(String data) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text("Alert"),
        content: new Text(data),
        actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  _editData(CollectionReference collectionReference,
      DocumentSnapshot documentSnapshot) {
    String changedTitle;
    String changedDesc;
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text("Alert"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                changedTitle = value;
              },
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              onChanged: (value) {
                changedDesc = value;
              },
              decoration: InputDecoration(
                labelText: "Description",
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Change'),
            onPressed: () async {
              await _updateData(
                  changedTitle == null ? "" : changedTitle,
                  changedDesc == null ? "" : changedDesc,
                  collectionReference,
                  documentSnapshot);
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  _askToDelete(
      CollectionReference collectionReference, DocumentSnapshot document) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text("Alert"),
        content: new Text("Are you sure want to delete?"),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () async {
              await collectionReference.doc(document.id).delete();
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
