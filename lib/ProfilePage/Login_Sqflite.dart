import 'package:flutter/material.dart';
import 'package:kisaan/ProfilePage/AddressPincodePage.dart';
import 'package:kisaan/HomePage/OrderPage.dart';
import 'package:kisaan/ProfilePage/database_connector.dart';
import 'dart:async';

import 'package:sqflite/sqflite.dart';

class insertPage extends StatelessWidget {
  int id;

  String name;

  String address;

  int fetchData = 0;

// This widget is the root of your application.

  insertPage({this.id});

  var txt_1 = TextEditingController();

  var txt_2 = TextEditingController();

  var txt_3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
//print(""+id.toString());

    if (id != 0) {
      DBConDisplaySpecificId(id);
    }

    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: txt_2,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Address Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: txt_1,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Name Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Login',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        debugPrint("Proceed button clicked");

                        getValuesFromTextbox();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressPincodePage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                ],
              ),
            )
          ])),
    );
  }

  void getValuesFromTextbox() {
    DatabaseConnect con = DatabaseConnect();

    final Future<int> dbFuture =
        con.insertUpdateDynamic(id, txt_1.text, txt_2.text);
  }

  void DBConDisplaySpecificId(id) {
    DatabaseConnect con = DatabaseConnect();

    List<Map<String, dynamic>> list = [];

    final Future<Database> dbFuture = con.initializeDatabase();

    dbFuture.then((database) {
      Future<List<Map<String, dynamic>>> noteListFuture =
          con.getSpecificEmployee(id);

      noteListFuture.then((emp_data) {
        for (var i = 0; i < emp_data.length; i++) {
          Map m = emp_data[i];

          m.forEach((k, v) => {
//print('${k}: ${v}'),

                if ('${k}' == "name")
                  {
                    txt_1.text = '${v}',
                  },

                if ('${k}' == "address")
                  {
                    txt_2.text = '${v}',
                  }
              });
        }

        print(emp_data);
      });
    });
  }
}
