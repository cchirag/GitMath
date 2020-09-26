import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gitmath/Screens/CreateRepoScreen.dart';
import 'package:gitmath/Screens/HomeScreen.dart';
import 'package:gitmath/Screens/ProfileScreen.dart';
import 'package:gitmath/Screens/RootScreen.dart';
import 'package:gitmath/Screens/SignInScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => RootScreen(),
        "/signin": (context) => SignInScreen(),
        "/home": (context) => HomeScreen(),
        "/profile": (context) => ProfileScreen(),
        "/createRepo": (context) => CreateRepoScreen()
      },
    );
  }
}
