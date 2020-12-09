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
  @override
  Widget build(BuildContext context) {
    // if (!widget.firebaseUser.emailVerified) {
    //   widget.firebaseUser.sendEmailVerification();
    //   print("email verification sent");
    // }
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
      body: widget.firebaseUser.emailVerified
          ? Center(
              child: Text("Welcome"),
            )
          : Center(
              child: Text(
                "Please Verify Email to use the app",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 32,
                ),
              ),
            ),
    );
  }
}
