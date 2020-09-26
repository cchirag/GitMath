import 'package:flutter/material.dart';
import 'package:gitmath/Components/AppDrawerComponent.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Color(0XFF5C7ECC),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Color(0XFF5A5A5E),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0XFF5C7ECC), width: 1.0),
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
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.add_circle_outline,
              color: Color(0XFF5C7ECC),
            ),
          ),
        ],
      ),
      drawer: AppDrawerComponent(),
      body: Container(
          color: Colors.black,
          child: Center(
            child: Text("Home"),
          )),
    );
  }
}
