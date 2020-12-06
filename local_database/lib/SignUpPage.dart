import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  final String data;
  SignUpPage({
    this.data,
  });
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Media"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          "Enter email and password to create account",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            onChanged: (val) {
              _email = val;
            },
            decoration: InputDecoration(labelText: "Email"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
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
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                registerUser(_email, _password);
              },
            ),
          ),
        ),
      ]),
    );
  }

  registerUser(String email, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(email, pass);
    _showMaterialDialog("User is successfully created");
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
}
