import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whiteboardkit/sketch_stream_controller.dart';
import 'package:whiteboardkit/whiteboardkit.dart';

class WhiteBoardArgs {
  final String svg;
  final String docId;
  WhiteBoardArgs(this.docId, this.svg);
}

class WhiteBoardScreen extends StatefulWidget {
  final args;
  WhiteBoardScreen(this.args,{Key key}) : super(key: key);

  @override
  _WhiteBoardScreenState createState() => _WhiteBoardScreenState();
}

class _WhiteBoardScreenState extends State<WhiteBoardScreen> {
  DrawingController controller;

  var _currentSVG;

  @override
  void initState() {
    var draw = WhiteboardDraw.fromWhiteboardSVG(widget.args.svg);
    controller = new DrawingController(draw: draw);
    controller.onChange().listen((event) {
      setState(() {
        _currentSVG = controller.getDraw().getSVG();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Hello",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.publish),
              onPressed: () {
                FirebaseFirestore.instance.collection("repositories").doc(widget.args.docId).update({
                  "versions": FieldValue.arrayUnion([{
                    "createdBy": FirebaseAuth.instance.currentUser.displayName,
                    "data": _currentSVG,
                    "createdAt": DateTime.now().millisecondsSinceEpoch
                  }])
                }).then((value){Navigator.pop(context);});
              },
              color: Colors.white,
            )
          ],
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Whiteboard(
                  controller: controller,
                ),
              ),
            ],
          ),
        ));
  }
}
