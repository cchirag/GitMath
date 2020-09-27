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
  bool isMounted = false;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    isMounted = true;
    print("root init");
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        if (isMounted) {
          setState(() {
            isAuthenticated = false;
          });
        }
      } else {
        if (isMounted) {
          setState(() {
            isAuthenticated = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    print("root dispo");
    isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isAuthenticated ? HomeScreen() : SignInScreen();
  }
}
