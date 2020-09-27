import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gitmath/Screens/RepoViewScreen.dart';

class RepoDisplayComponent extends StatefulWidget {
  final DocumentSnapshot _document;

  RepoDisplayComponent(this._document, {Key key}) : super(key: key);

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
          onPressed: () async {
            final query = FirebaseFirestore.instance
                .collection("users")
                .doc(widget._document.data()["createdBy"])
                .get();
            var author = "";
            query.then((value) {
              setState(() {
                author = value.data()["name"];
              });
            }).then(
              (value) => Navigator.pushNamed(
                context,
                "/repoView",
                arguments: RepoViewScreenArgs(widget._document.data()["name"],
                    author, widget._document.id),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget._document.data()["name"],
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "v" + widget._document.data()["versions"].length.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
    );
  }
}
