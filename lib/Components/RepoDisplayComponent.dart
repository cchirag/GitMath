import 'package:flutter/material.dart';

class RepoDisplayComponent extends StatefulWidget {
  RepoDisplayComponent({Key key}) : super(key: key);

  @override
  _RepoDisplayComponentState createState() => _RepoDisplayComponentState();
}

class _RepoDisplayComponentState extends State<RepoDisplayComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      color: Color(0XFF5C7ECC),
      child: FlatButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Repo Name",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "Current Version",
                style: TextStyle(color: Colors.white),
              ),

            ],
          )),
    );
  }
}
