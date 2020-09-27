
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInComponent extends StatefulWidget {
  SignInComponent({Key key}) : super(key: key);

  @override
  _SignInComponentState createState() => _SignInComponentState();
}

class _SignInComponentState extends State<SignInComponent> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  handleSubmit() async {
    setState(() {
      _loading = true;
    });
    final _auth = FirebaseAuth.instance;
    _auth
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      setState(() {
        _loading = false;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: TextField(
            controller: _emailController,
            style: TextStyle(color: Colors.white),
            cursorColor: Color(0XFF5C7ECC),
            decoration: InputDecoration(
              hintText: "Email",
              hintStyle: TextStyle(
                color: Color(0XFF5A5A5E),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0XFF5C7ECC), width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0XFF5A5A5E),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: TextField(
            obscureText: true,
            controller: _passwordController,
            style: TextStyle(color: Colors.white),
            cursorColor: Color(0XFF5C7ECC),
            decoration: InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(
                color: Color(0XFF5A5A5E),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0XFF5C7ECC), width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0XFF5A5A5E),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: FlatButton(
            onPressed: () {
              handleSubmit();
            },
            child: _loading
                ? CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0XFFFA7777)),
                  )
                : Text(
                    "Sign In",
                    style: TextStyle(fontSize: 20),
                  ),
            textColor: Colors.white,
            color: Color(0XFF5C7ECC),
          ),
        ),
        Text(
          "or",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: SignInButton(
              Buttons.Google,
              text: "Sign In with Google",
              onPressed: () {},
            )),
      ],
    );
  }
}
