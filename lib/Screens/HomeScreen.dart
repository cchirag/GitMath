import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gitmath/Components/AppDrawerComponent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gitmath/Components/RepoDisplayComponent.dart';
import 'package:gitmath/Screens/CreateRepoScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchTerm = TextEditingController();
  final _repoNameController = TextEditingController();

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
            child: IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: Color(0XFF5C7ECC),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    backgroundColor: Color(0XFF2A2A2A),
                    title: Text("Create Repository"),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    children: [
                      CreateRepoScreen(
                        name: _repoNameController,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: FlatButton(
                            color: Color(0XFF5C7ECC),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection("repositories")
                                  .doc()
                                  .set(
                                {
                                  "name": _repoNameController.text,
                                  "createdBy":
                                      FirebaseAuth.instance.currentUser.uid,
                                  "lastPush": null,
                                  "versions": []
                                },
                              ).then((value) {
                                _repoNameController.text = '';
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "Create",
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                );
              },
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
