import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kisaan/ProfilePage/Login_Sqflite.dart';
import 'package:kisaan/ExtrasPage/kisaan_icondart_icons.dart';
import 'package:kisaan/ExtrasPage/sqlflite_main.dart';
import 'package:kisaan/ProfilePage/CustomerSupport.dart';
import 'package:sqflite/sqflite.dart';
import '../ExtrasPage/Functions.dart';
import '../ExtrasPage/globals.dart';
import 'LoginPage.dart';
import '../ExtrasPage/StyleScheme.dart';
import 'package:kisaan/ProfilePage/database_connector.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: profilePage(),
    );
  }
}

class profilePage extends StatefulWidget {
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  Future<String> getUserName() async {
    var a;
    DatabaseConnect con = DatabaseConnect();
    final Future<Database> dbFuture = con.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Map<String, dynamic>>> noteListFuture = con.getList();
      noteListFuture.then((emp_data) {
        print(emp_data[0]['name']);
        a = emp_data[0]['name'];
      });
    });
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
            Text(
              "Welcome!",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              "Login to view your profile",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              DatabaseConnect con = DatabaseConnect();
              final Future<Database> dbFuture = con.initializeDatabase();
              dbFuture.then((database) {
                Future<List<Map<String, dynamic>>> noteListFuture =
                    con.getList();
                noteListFuture.then((emp_data) {
                  if (emp_data.isNotEmpty) {
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(""),
                        content: Text("You are already logged in !"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => insertPage(id: 0)));
                  }
                });
              });
            },
            child: Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                margin: EdgeInsets.fromLTRB(0, 30, 30, 20),
                height: 50,
                decoration: BoxDecoration(
                  gradient: gradientStyleBlue,
                ),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                )),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "        my information",
                style: headingStyle.copyWith(
                  fontWeight: FontWeight.w200,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              clothWidget("cloth1", "my orders", 0),
              SizedBox(
                height: 35,
              ),
              Text(
                "        others",
                style: headingStyle.copyWith(
                  fontWeight: FontWeight.w200,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              clothWidget("cloth4",
                  "Customer Support / Rate Us / \n Feedback / Complaints", 3),
              InkWell(
                onTap: () {
                  DatabaseConnect con = DatabaseConnect();
                  final Future<Database> dbFuture = con.initializeDatabase();
                  dbFuture.then((database) {
                    Future<List<Map<String, dynamic>>> noteListFuture =
                        con.getList();
                    noteListFuture.then((emp_data) {
                      if (emp_data.isNotEmpty) {
                        con.deleteEntry(emp_data[0]['id']);
                      }
                    });
                  });

                  globals.get_googleSignIn().signOut().then((value) {
                    setState(() {
                      globals.set_isLoggedin(false);
                    });
                  }).catchError((e) {});

                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(""),
                      content: Text("Logged Out Successfully"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    margin: EdgeInsets.fromLTRB(0, 30, 30, 20),
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: gradientStyleBlue,
                    ),
                    child: Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        iconSize: 30,
        currentIndex: 3,
        onTap: (value) => {FunctionsPage.openRelevantPage(value, context)},
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(KisaanIcondart.vegetables), title: Text("Vegetables")),
          BottomNavigationBarItem(
              icon: Icon(KisaanIcondart.pear), title: Text("Fruits")),
          BottomNavigationBarItem(
              icon: Icon(Icons.track_changes), title: Text("Profile")),
        ],
      ),
    );
  }

  Container clothWidget(String img, String name, int choice) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
        ),
        onPressed: () {
          switch (choice) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Sqlfliteee()));
              break;
            case 1:
              break;
            case 2:
              break;
            case 3:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => WhatsApp()));
              break;
            case 4:
              break;
            default:
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(4),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/images/$img.png'))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$name",
                  style: headingStyle.copyWith(
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //void openRelevantPage(int pageId) {
  //  switch (pageId) {
  //    case 1:
  //      Navigator.push(
  //          context, MaterialPageRoute(builder: (context) => VegetablesPage()));
  //      break;
  //    case 2:
  //      Navigator.push(
  //          context, MaterialPageRoute(builder: (context) => FruitsPage()));
  //      break;
  //    case 3:
  //      Navigator.push(
  //          context, MaterialPageRoute(builder: (context) => ProfilePage()));
  //      break;
  //    default:
  //  }
  //}
}
