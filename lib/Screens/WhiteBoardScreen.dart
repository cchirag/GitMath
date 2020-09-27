import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whiteboardkit/sketch_stream_controller.dart';
import 'package:whiteboardkit/whiteboardkit.dart';

class WhiteBoardArgs {
  final String docId;
  WhiteBoardArgs(this.docId);
}

class WhiteBoardScreen extends StatefulWidget {
  WhiteBoardScreen({Key key}) : super(key: key);

  @override
  _WhiteBoardScreenState createState() => _WhiteBoardScreenState();
}

class _WhiteBoardScreenState extends State<WhiteBoardScreen> {
  DrawingController controller;

  var _currentSVG;
  String drawSVG;

  @override
  void initState() {
    var draw = WhiteboardDraw.fromWhiteboardSVG("");
    controller = new DrawingController(draw: draw, enableChunk: true);
    controller.onChange().listen((event) {
      setState(() {
        _currentSVG = controller.getDraw().getSVG();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WhiteBoardArgs args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.docId,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.publish),
            onPressed: () {
              Navigator.pop(context);
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
      ),
    );
  }
}
