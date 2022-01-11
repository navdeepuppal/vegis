import 'package:flutter/material.dart';
import 'package:kisaan/HomePage/OrderPage.dart';
import 'package:kisaan/ProfilePage/Login_Sqflite.dart';
import 'package:kisaan/ProfilePage/database_connector.dart';
import 'package:sqflite/sqflite.dart';
import '../HomePage/HomePage.dart';

class LoginDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginDemo(),
    );
  }
}

class loginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<loginDemo> {
  int id;

  String name;

  String address;

  int fetchData = 0;

// This widget is the root of your application.

  _LoginDemoState({this.id});

  var txt_1 = TextEditingController();

  var txt_2 = TextEditingController();

  var txt_3 = TextEditingController();

  var txt_4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (id != 0) {
      DBConDisplaySpecificId(id);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/bannerIm.png')),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: txt_1,
                //  obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number*',
                    hintText: 'You will recieve a call for verification'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: txt_2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  //hintText: 'Name'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: txt_3,
                //  obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Current Address',
                    hintText: 'Floor/ Building, Locality, Area, Landmark'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: txt_4,
                //  obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pincode',
                  //hintText: 'Floor/ Building, Locality, Area, Landmark'
                ),
              ),
            ),

            // FlatButton(
            //   onPressed: () {
            //     //TODO FORGOT PASSWORD SCREEN GOES HERE
            //   },
            //   child: Text(
            //     'Forgot Password',
            //     style: TextStyle(color: Colors.blue, fontSize: 15),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderPage()),
                  );
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),

            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  debugPrint("Proceed button clicked");
                  getValuesFromTextbox();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderPage()),
                  );
                },
                child: Text(
                  'Go Back',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),

            //Text('New User? Create Account')
          ],
        ),
      ),
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
