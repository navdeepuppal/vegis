import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kisaan/HomePage/OrderConfirmed.dart';
import 'package:kisaan/HomePage/OrderPage.dart';
import '../ExtrasPage/SignUpPage.dart';
import '../HomePage/HomePage.dart';
import 'package:sqflite/sqflite.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'roboto'),
      home: loginPage(),
    );
  }
}

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    final _dbRef = FirebaseDatabase.instance.reference();
    final phoneC = TextEditingController();
    final nameC = TextEditingController();
    final addressC = TextEditingController();
    final pincodeC = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => OrderPage()));
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PLACE ORDER",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'sfpro'),
                ),
                Text(
                  "Please Enter Your Details For Confirming Order",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: phoneC,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                  ),
                ),
                TextField(
                  controller: nameC,
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                ),
                TextField(
                  controller: addressC,
                  decoration: InputDecoration(
                    labelText: "Full Address",
                  ),
                ),
                TextField(
                  controller: pincodeC,
                  decoration: InputDecoration(
                    labelText: "PinCode",
                  ),
                ),
                //Row(
                //  mainAxisAlignment: MainAxisAlignment.end,
                //  children: [
                //    Text(
                //      "Forgot Password?",
                //      style: TextStyle(color: Colors.grey),
                //    ),
                //  ],
                //),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () async {
                    DateFormat dateFormat3 = DateFormat('yy MM dd');
                    var tableRef =
                        _dbRef.child(dateFormat3.format(DateTime.now()));
                    int phoneNo = int.parse(phoneC.text);
                    String name = nameC.text;
                    String address = addressC.text;
                    int pincode = int.parse(pincodeC.text);
                    print([phoneNo, name, address, pincode]);
                    DateFormat dateFormat = DateFormat('yy-MM-dd HH:mm');
                    DateFormat dateFormat2 = DateFormat('dd MMMM yy');
                    String orderID =
                        "${dateFormat.format(DateTime.now()).replaceAll(".", "").replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "")}$phoneNo";

                    await tableRef.child("$orderID").set({
                      'OrderID': orderID,
                      'Pincode': 160062,
                      'Phone': phoneNo,
                      'Name': "Navi",
                      'Address': 'Kothi #103 Phase 9 Mohali',
                      'TotalAmount': 229,
                      'COD': "TRUE",
                      'Vegetables': "onion: 2kg, aloo: 3kg, ghiya: 5kg",
                      'Fruits': "apple: 2kg, banana: 3kg, orange: 5kg",
                      'Date': dateFormat2.format(DateTime.now()),
                      'TrackStatus': "Deievered"
                    });
                    tableRef.push();
                    print([phoneNo, name, address, pincode]);
                    var databasesPath = await getDatabasesPath();
                    String path = databasesPath.toString() + 'sqflite_login.db';

                    var sqflite_login_db = await openDatabase(path, version: 1,
                        onCreate: (Database db, int version) async {
                      // When creating the db, create the table
                      await db.execute(
                          'CREATE TABLE UserData (phone INTEGER PRIMARY KEY, name TEXT, address TEXT, pincode INTEGER)');
                    });

                    await sqflite_login_db.transaction((txn) async {
                      int id = await txn.rawInsert(
                          'INSERT INTO UserData(phone, name, address, pincode) VALUES(?, ?, ?, ?)',
                          [phoneNo, name, address, pincode]);
                      print('inserted: $id');
                    });
                    print([phoneNo, name, address, pincode]);

                    await sqflite_login_db.close();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderConfirmPage()));
                  },

                  //onTap: openHomePage,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                            colors: [Color(0xfff3953b), Color(0xffe57509)],
                            stops: [0, 1],
                            begin: Alignment.topCenter)),
                    child: Center(
                      child: Text(
                        "    PLACE ORDER \n\n Cash On Delievery",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'sfpro'),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: Container(
                //         height: 1,
                //         color: Colors.grey,
                //       ),
                //     ),
                //     Center(
                //       child: Container(
                //           padding: EdgeInsets.all(10), child: Text("OR")),
                //     ),
                //     Expanded(
                //       child: Container(
                //         height: 1,
                //         color: Colors.grey,
                //       ),
                //     ),
                //   ],
                // ),
                //SizedBox(
                //  height: 20,
                //),
                //Row(
                //  mainAxisAlignment: MainAxisAlignment.center,
                //  children: [
                //    Container(
                //        height: 60,
                //        width: 260,
                //        //decoration: BoxDecoration(
                //        //  shape: BoxShape.circle,
                //        //  border: Border.all(color: Colors.black, width: 0.5),
                //        //),
                //        child: FloatingActionButton.extended(
                //          onPressed: () {
                //            globals
                //                .get_googleSignIn()
                //                .signIn()
                //                .then((userData) {
                //              setState(() {
                //                globals.set_isLoggedin(true);
                //                globals.set_userObj(userData);
                //                openHomePage();
                //              });
                //            }).catchError((e) {
                //              print(e);
                //            });
                //          },
                //          icon: Image.asset(
                //            'asset/images/googleLogo.png',
                //            height: 30,
                //            width: 30,
                //          ),
                //          label: Text("Sign in to Google"),
                //          backgroundColor: Colors.white,
                //          foregroundColor: Colors.black,
                //        )
                //        //child: ElevatedButton.icon(
                //        //  style: ElevatedButton.styleFrom(
                //        //    primary: Colors.white,
                //        //    onPrimary: Colors.black,
                //        //    minimumSize: Size(double.infinity, 50),
                //        //  ),
                //        //
                //        //  icon: FaIcon(FontAwesomeIcons.google,
                //        //      color: Colors.red),
                //        //  label: Text('Sign Up with Google'),
                //        //  onPressed: () {
                //        //    _googleSignIn.signIn().then((userData) {
                //        //      setState(() {
                //        //        _isLoggedIn = true;
                //        //        _userObj = userData;
                //        //      });
                //        //    }).catchError((e) {
                //        //      print(e);
                //        //    });
                //        //  },
                //        //),
                //        //child: InkWell(
                //        //  child: Container(
                //        //    child: Text("Sign in with GOOGLE"),
                //        //    decoration: BoxDecoration(
                //        //      image: DecorationImage(
                //        //        image:
                //        //            AssetImage('asset/images/googleLogo.png'),
                //        //      ),
                //        //    ),
                //        //  ),
                //        //  onTap: () {
                //        //
                //        //  },
                //        //),
                //        ),
                //    //SizedBox(
                //    //  width: 20,
                //    //),
                //    //Container(
                //    //  height: 60,
                //    //  width: 60,
                //    //  decoration: BoxDecoration(
                //    //      shape: BoxShape.circle,
                //    //      border:
                //    //          Border.all(color: Colors.black, width: 0.5)),
                //    //  child: Container(
                //    //    decoration: BoxDecoration(
                //    //        image: DecorationImage(
                //    //            image:
                //    //                AssetImage('asset/images/fbLogo.png'))),
                //    //  ),
                //    //)
                //  ],
                //)
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       "Don't have an account?",
          //       style: TextStyle(fontSize: 16, fontFamily: 'sfpro'),
          //     ),
          //     InkWell(
          //       onTap: openSignUpPage,
          //       child: Text(
          //         " SIGN UP",
          //         style: TextStyle(
          //             color: Colors.blue,
          //             fontSize: 16,
          //             fontWeight: FontWeight.w700),
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(
          //   height: 10,
          // )
        ],
      ),
    );
  }

  void openSignUpPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  void openHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
