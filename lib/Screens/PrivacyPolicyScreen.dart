import 'package:flutter/material.dart';
import 'package:gitmath/Components/AppDrawerComponent.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawerComponent(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Privacy Policy",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.black,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Text(
            "The content for GitMath has been developed by GitMath Team. However, GitMath runs on systems provided by Google Firebase, and GitMath Team does not have full access to the app. In particular, GitMath Team has no ability to access the messages you send to GitMath or the responses that it sends back to you. \n \n GitMath Team may receive from Firebase iidentifying information about the use of GitMath. For instance, GitMath Team can access usage information regarding how many users are using the app, which geographical regions they are located in, and basic data including users’ language, device type, and length and frequency of use. None of the information GitMath Team receives from Google’s Firebase identifies you, nor does it reveal to GitMath Team what information you sent to the app or what specific responses the app sent to you.",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
