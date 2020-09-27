import 'package:flutter/material.dart';
import 'package:gitmath/Components/AppDrawerComponent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gitmath/Components/RepoDisplayComponent.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchTerm = TextEditingController();

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
                controller: _searchTerm,
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
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.all(20),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("repositories")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );
                return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return RepoDisplayComponent(
                            snapshot.data.documents[index]);
                      }),
                );
              },
            ),
          )),
    );
  }
}
