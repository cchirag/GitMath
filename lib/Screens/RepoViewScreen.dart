import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gitmath/Screens/WhiteBoardScreen.dart';

class RepoViewScreenArgs {
  final String name;
  final String author;
  final String docId;
  RepoViewScreenArgs(this.name, this.author, this.docId);
}

class RepoViewScreen extends StatefulWidget {
  final args;

  RepoViewScreen(this.args, {Key key}) : super(key: key);

  @override
  _RepoViewScreenState createState() => _RepoViewScreenState();
}

class _RepoViewScreenState extends State<RepoViewScreen> {
  BuildContext context;
  var _itemCount = 0;
  var _items = [];
  bool isMounted = false;

  @override
  void initState() {
    isMounted = true;
    FirebaseFirestore.instance
        .collection("repositories")
        .doc(widget.args.docId)
        .snapshots()
        .listen((event) {
      if (isMounted) {
        setState(() {
          _itemCount = event.data()["versions"].length;
          _items = event.data()["versions"];
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.args.name,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, "/whiteBoard");
            },
            color: Colors.white,
          )
        ],
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        padding: EdgeInsets.all(20),
        child: Container(
          color: Color(0XFF1C1C1E),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                color: Colors.black,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Repository Name: " + widget.args.name,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Created By: " + widget.args.author,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    color: Colors.black,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: _items
                            .map((e) => FlatButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/whiteBoard",
                                        arguments: WhiteBoardArgs(widget.args.docId,e["data"]));
                                  },
                                  child: Text(
                                    e["data"],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList(),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
