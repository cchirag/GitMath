import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gitmath/Screens/HomeScreen.dart';
import 'package:gitmath/Screens/SignInScreen.dart';

class RootScreen extends StatefulWidget {
  RootScreen({Key key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool isAuthenticated = false;

  @override
  void initState() {
    final _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          isAuthenticated = true;
        });
      } else {
        setState(() {
          isAuthenticated = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isAuthenticated ? HomeScreen() : SignInScreen();
  }
}
