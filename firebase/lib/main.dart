import 'package:firebase/Service/authentication_service.dart';
import 'package:firebase/Timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) =>
              AuthenticationService(firebaseAuth: FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return Timeline(
        firebaseUser: firebaseUser,
      );
    } else {
      return MyHomePage();
    }
  }
}

class MyHomePage extends StatelessWidget {
  String _email;
  String _pass;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value.length == 0) {
                    return "Please enter email";
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Email"),
                onChanged: (v) {
                  _email = v;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                onChanged: (v) {
                  _pass = v;
                },
                validator: (value) {
                  if (value.length == 0) {
                    return "Please enter password";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    color: Colors.blue,
                    child: Text("Sign In"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        context
                            .read<AuthenticationService>()
                            .signIn(_email, _pass);
                      }
                    },
                  ),
                  FlatButton(
                    color: Colors.green,
                    child: Text("Register"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        context
                            .read<AuthenticationService>()
                            .signUp(_email, _pass);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
