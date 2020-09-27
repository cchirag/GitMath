import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawerComponent extends StatefulWidget {
  AppDrawerComponent({Key key}) : super(key: key);

  @override
  _AppDrawerComponentState createState() => _AppDrawerComponentState();
}

class _AppDrawerComponentState extends State<AppDrawerComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 20),
      decoration: BoxDecoration(
        color: Color(0XFF2A2A2A),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 55,
                child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser.photoURL),
                    radius: 50)),
          ),
          Text(
            FirebaseAuth.instance.currentUser.displayName,
            style: TextStyle(
                color: Color(0XFF5C7ECC),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 0),
            color: Colors.transparent,
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Home",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                        )))
              ],
            ),
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 0),
            color: Colors.transparent,
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Profile",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                        )))
              ],
            ),
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 0),
            color: Colors.transparent,
            onPressed: () {
              Navigator.pushNamed(context, "/privacypolicy");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.event_note,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Privacy Policy",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                        )))
              ],
            ),
          ),
          Container(
            child: FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 0),
              color: Colors.transparent,
              onPressed: () {
                Navigator.pop(context);
                FirebaseAuth.instance.signOut();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Sign Out",
                    style: TextStyle(color: Color(0XFF5C7ECC), fontSize: 18),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.exit_to_app,
                        color: Color(0XFF5C7ECC),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
