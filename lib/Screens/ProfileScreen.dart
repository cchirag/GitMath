import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gitmath/Components/AppDrawerComponent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gitmath/Components/RepoDisplayComponent.dart';
import 'package:gitmath/Screens/CreateRepoScreen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _status = "Thinking";
  bool _bioIsEditable = false;
  final _bioController = TextEditingController();
  final _repoNameController = TextEditingController();
  bool isMounted = false;

  @override
  void initState() {
    isMounted = true;
    fetchData() async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((snapShot) {
        if (snapShot.exists) {
          if (isMounted) {
            setState(() {
              _status = snapShot.get("status");
              _bioController.text = snapShot.get("bio");
            });
          }
        }
      });
    }

    fetchData();
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
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Profile"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              splashRadius: 20,
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
              icon: Icon(
                Icons.add_circle_outline,
                color: Color(0XFF5C7ECC),
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawerComponent(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 55,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              FirebaseAuth.instance.currentUser.photoURL),
                          radius: 50),
                    ),
                  ),
                  Container(
                    child: Text(
                      FirebaseAuth.instance.currentUser.displayName,
                      style: TextStyle(
                          color: Color(0XFF5C7ECC),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Color(0XFF1C1C1E),
                width: MediaQuery.of(context).size.width * 0.9,
                child: DropdownButton<String>(
                  dropdownColor: Colors.black,
                  items:
                      <String>["Solving", "Thinking", "Focusing"].map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (selected) async {
                    setState(() {
                      _status = selected;
                    });
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .update({"status": _status});
                  },
                  isExpanded: true,
                  value: _status,
                ),
              ),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 20),
                    color: Color(0XFF1C1C1E),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _bioController,
                      enabled: _bioIsEditable ? true : false,
                      maxLines: 7,
                      decoration: InputDecoration(
                        hintText: "Bio",
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
                  Positioned(
                    bottom: 25,
                    right: 0,
                    child: IconButton(
                      splashRadius: 1,
                      icon: _bioIsEditable
                          ? Icon(
                              Icons.save,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                      onPressed: () {
                        setState(() {
                          _bioIsEditable = !_bioIsEditable;
                        });
                        if (_bioIsEditable == false) {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .update({"bio": _bioController.text});
                        }
                      },
                    ),
                  )
                ],
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(20),
                  color: Color(0XFF1C1C1E),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Repo",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("repositories")
                              .snapshots(),
                          builder: (context, snapshot) {
                            return Expanded(
                                child: snapshot.hasData == false
                                    ? CircularProgressIndicator()
                                    : ListView.builder(
                                        itemCount:
                                            snapshot.data.documents.length,
                                        itemBuilder: (context, index) {
                                          return RepoDisplayComponent(
                                              snapshot.data.documents[index]);
                                        }));
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
