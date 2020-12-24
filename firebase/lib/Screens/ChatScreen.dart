import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('messages');

  String message;
  final _textEditingController = TextEditingController();
  final ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Our Chat'),
        actions: [
          FlatButton.icon(
            icon: Icon(
              Icons.supervised_user_circle,
              color: Colors.white,
            ),
            label: Text(
              "Sign Out",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              // width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 1.3,
              child: StreamBuilder<QuerySnapshot>(
                stream: messageCollection
                    // .where(
                    //   'uid',
                    //   isEqualTo: FirebaseAuth.instance.currentUser.uid,
                    // )
                    .orderBy('createdAt')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  if (snapshot.data.size == 0) {
                    return Center(
                      child: Text(
                        "No messages found",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  return new ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    // reverse: true,
                    physics: ScrollPhysics(),
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return Align(
                        alignment: document['uid'] ==
                                FirebaseAuth.instance.currentUser.uid
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 8.0,
                          ),
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 7,
                                  blurRadius: 5,
                                  offset: Offset(
                                      1, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document['message'],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textEditingController,
                  onChanged: (value) {
                    message = value;
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    labelText: "Add a message",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    suffix: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        if (message != null) {
                          addMessage(message);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addMessage(String message) {
    return messageCollection.add({
      'message': message,
      'createdAt': Timestamp.now(),
      'uid': FirebaseAuth.instance.currentUser.uid,
      'email': FirebaseAuth.instance.currentUser.email,
    }).then((value) {
      _textEditingController.clear();
      _scrollController.animateTo(
        1,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    });
  }
}
