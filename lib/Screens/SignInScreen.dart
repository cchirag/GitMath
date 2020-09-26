import 'package:flutter/material.dart';
import 'package:gitmath/Components/SignInComponent.dart';
import 'package:gitmath/Components/SignUpComponent.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _signInActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  _signInActive ? 'Welcome' : "Hello, \nProblem Solver!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {
                      setState(() {
                        _signInActive = true;
                      })
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color:
                              _signInActive ? Colors.white : Color(0XFF5A5A5E),
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "|",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => {
                      setState(() {
                        _signInActive = false;
                      })
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color:
                              _signInActive ? Color(0XFF5A5A5E) : Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              _signInActive ? SignInComponent() : SignUpComponent()
            ],
          ),
        ),
      ),
    );
  }
}
