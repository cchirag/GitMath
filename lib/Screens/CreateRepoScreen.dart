import 'package:flutter/material.dart';

class CreateRepoScreen extends StatefulWidget {
  final TextEditingController name;

  CreateRepoScreen({this.name, Key key}) : super(key: key);

  @override
  _CreateRepoScreenState createState() => _CreateRepoScreenState();
}

class _CreateRepoScreenState extends State<CreateRepoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 20),
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
          style: TextStyle(color: Colors.white),
          controller: widget.name,
          decoration: InputDecoration(
            hintText: "Repository Name",
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
    );
  }
}
