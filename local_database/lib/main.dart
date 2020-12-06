import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_database/SignUpPage.dart';
import 'package:local_database/TimeLine.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _email;
  String _password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Media"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Welcome",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Put credentials to login",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                validator: (value) {
                  if (value.length == 0) return "Please enter email address";
                  return null;
                },
                onChanged: (val) {
                  _email = val;
                },
                decoration: InputDecoration(labelText: "Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                validator: (value) {
                  if (value.length == 0) return "Please enter password";
                  return null;
                },
                obscureText: true,
                onChanged: (val) {
                  _password = val;
                },
                decoration: InputDecoration(labelText: "Password"),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 55,
                width: size.width,
                child: FlatButton(
                  color: Colors.blue,
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      userLogin(_email, _password);
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 55,
                width: size.width,
                child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(
                          data: "Sample",
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Want to register?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  userLogin(String email, String password) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      dynamic data = sharedPreferences.getString(_email);
      if (data == null) {
        if (Platform.isIOS) {
          _showCupertinoDialog(
            "User is not registered.\nPlease go to Sign Up Page.",
          );
        } else {
          _showMaterialDialog(
            "User is not registered.Please go to Sign Up Page.",
          );
        }
      } else {
        if (data == password) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimeLine(),
            ),
          );
        } else {
          _showMaterialDialog("Wrong Password");
        }
      }
    } catch (e) {}
  }

  _showMaterialDialog(String data) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text("Alert"),
        content: new Text(data),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  _showCupertinoDialog(String data) {
    showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
        title: new Text("Alert"),
        content: new Text(data),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
