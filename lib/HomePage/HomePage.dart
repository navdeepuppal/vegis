import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kisaan/ProfilePage/LoginPage_Sqflite.dart';
import 'package:kisaan/ExtrasPage/StyleScheme.dart';
import 'package:kisaan/ExtrasPage/kisaan_icondart_icons.dart';
import 'package:kisaan/VegetablesPage/VegetablesPage.dart';
import 'package:sqflite/sqflite.dart';
import '../ExtrasPage/Functions.dart';
import 'OrderPage.dart';
import 'package:provider/provider.dart';
import '../FruitsPage/Fruits_DB.dart';
import '../FruitsPage/FruitsPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List storedocs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,
        //leading: IconButton(
        //  icon: Icon(Icons.arrow_back_ios),
        //  color: Colors.black,
        //  onPressed: () {},
        //),

        title: Text(
          "GRANDPA'S FARM",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        ),

        actions: [
          IconButton(
            icon: Image.asset('asset/images/actions_logo.ico'),
            //onPressed: () => exit(0),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('fruits').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          storedocs = [];
          Fruits_DB f_con = Fruits_DB();
          final Future<Database> dbFuture = f_con.initializeDatabase();
          dbFuture.then((database) {
            snapshot.data.docs.map((DocumentSnapshot document) {
              Map a = document.data();
              storedocs.add(a);
              a['id'] = document.id;
            }).toList();
            print("Storedocs");
            for (var i = 0; i < storedocs.length; i++) {
              f_con.insertUpdateDynamic(
                  storedocs[i]['id'],
                  storedocs[i]['img'],
                  storedocs[i]['name'],
                  storedocs[i]['note'],
                  storedocs[i]['price'],
                  storedocs[i]['units'],
                  quantity: storedocs[i]['quantity']);
              print(storedocs[i]);
            }
            Future<List<Map<String, dynamic>>> noteListFuture = f_con.getList();
            noteListFuture.then((emp_data) {
              for (var i = 0; i < emp_data.length; i++) {
                Map m = emp_data[i];
                m.forEach((k, v) => print('${k}: ${v}'));
              }
              print(emp_data);
            });
          });

          return
              //ListView(
              //  children: snapshot.data.docs.map((document) {
              //    return Container(
              //      child: Center(child: Text(document['fruits'])),
              //    );
              //  }).toList(),
              //);
              Column(
            children: [
              Expanded(
                //
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xfff1ffff),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("FRUITS & VEGETABLES",
                                            style: headingStyle),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Serving fresh at \nyour doorstep",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 180,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'asset/images/bannerImg.png'))),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("OFFERS", style: headingStyle),
                        //Container(
                        //  height: 130,
                        //  child: Row(
                        //    children: [
                        //      Expanded(
                        //        child: Container(
                        //          color: Color(0xfff1fff0),
                        //          padding: EdgeInsets.all(20),
                        //          child: InkWell(
                        //            onTap: () {
                        //              Navigator.push(
                        //                  context,
                        //                  MaterialPageRoute(
                        //                      builder: (context) =>
                        //                          VegetablesPage()));
                        //            },
                        //            child: Column(
                        //              mainAxisAlignment: MainAxisAlignment.center,
                        //              children: [
                        //                Text(
                        //                  "Get Rs 50/- off on \n MINIMUM \n order of 400",
                        //                  textAlign: TextAlign.center,
                        //                  style: headingStyle,
                        //                ),
                        //                SizedBox(
                        //                  height: 10,
                        //                ),
                        //              ],
                        //            ),
                        //          ),
                        //        ),
                        //      ),
                        //      SizedBox(
                        //        width: 6,
                        //      ),
                        //    ],
                        //  ),
                        //),

                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      "Get ₹ 100/- cashback on MINIMUM order of 600",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text("", style: headingStyle),
                        Container(
                          height: 125,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.yellow[200],
                                  padding: EdgeInsets.all(30),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VegetablesPage()));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Select \nVegetables",
                                          textAlign: TextAlign.center,
                                          style: headingStyle.copyWith(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.red[200],
                                  padding: EdgeInsets.all(30),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FruitsPage()));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Select\nFruits",
                                          textAlign: TextAlign.center,
                                          style: headingStyle.copyWith(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //Container(
                        //  height: 200,
                        //  color: Color(0xfff1ffff),
                        //  child: Row(
                        //    children: [
                        //      Container(
                        //        height: 200,
                        //        width: 120,
                        //        decoration: BoxDecoration(
                        //            image: DecorationImage(
                        //                image: AssetImage(
                        //                    'asset/images/servicesImg.png'))),
                        //      ),
                        //      Expanded(
                        //        child: Container(
                        //          padding: EdgeInsets.all(30),
                        //          child: Column(
                        //            crossAxisAlignment: CrossAxisAlignment.end,
                        //            mainAxisAlignment: MainAxisAlignment.center,
                        //            children: [
                        //              Text(
                        //                "Order Fruits at Best Price",
                        //                style: headingStyle,
                        //              ),
                        //              SizedBox(
                        //                height: 10,
                        //              ),
                        //              InkWell(
                        //                onTap: () {
                        //                  Navigator.push(
                        //                      context,
                        //                      MaterialPageRoute(
                        //                          builder: (context) =>
                        //                              VegetablesPage()));
                        //                },
                        //                child: Container(
                        //                  decoration: BoxDecoration(
                        //                      gradient: gradientStyle,
                        //                      borderRadius: BorderRadius.all(
                        //                          Radius.circular(20))),
                        //                  padding: EdgeInsets.symmetric(
                        //                      vertical: 10, horizontal: 20),
                        //                  child: Text(
                        //                    "Place Order",
                        //                    style: TextStyle(
                        //                        color: Colors.white,
                        //                        fontWeight: FontWeight.w600),
                        //                  ),
                        //                ),
                        //              )
                        //            ],
                        //          ),
                        //        ),
                        //      )
                        //    ],
                        //  ),
                        //),
                        SizedBox(
                          height: 10,
                        ),
                        //Container(
                        //  padding: EdgeInsets.all(20),
                        //  width: MediaQuery.of(context).size.width,
                        //  color: Color(0xfff1ffff),
                        //  child: Column(
                        //    crossAxisAlignment: CrossAxisAlignment.start,
                        //    children: [
                        //      Row(
                        //        children: [
                        //          Text(
                        //            "OFFER ",
                        //            style: contentStyle,
                        //          ),
                        //          Text(
                        //            "AVAILABLE",
                        //            style:
                        //                contentStyle.copyWith(color: Colors.blue),
                        //          )
                        //        ],
                        //      ),
                        //      SizedBox(
                        //        height: 10,
                        //      ),
                        //      Text(
                        //        "60% off upto Rs. 120  ",
                        //        style: contentStyle,
                        //      ),
                        //      Text(
                        //        "Use Coupon Code : FIRSTORDER",
                        //        style: contentStyle.copyWith(color: Colors.blue),
                        //      )
                        //    ],
                        //  ),
                        //),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xfff1ffff),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "CURRENT SERVICE AVAILABILTY AREA'S",
                                style: contentStyle.copyWith(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Mohali, Chandigarh, Ludhiana, Panchkula, Jalandhar",
                                style: contentStyle,
                              ),
                            ],
                          ),
                        ),
                        //Row(
                        //  mainAxisAlignment: MainAxisAlignment.end,
                        //  children: [
                        //    Container(
                        //      padding: EdgeInsets.all(15),
                        //      decoration: BoxDecoration(
                        //          gradient: gradientStyle, shape: BoxShape.circle),
                        //      child: Text(
                        //        "+",
                        //        style: TextStyle(color: Colors.white, fontSize: 40),
                        //      ),
                        //    )
                        //  ],
                        //),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrderPage()));
                },
                child: Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(10),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "YOUR CART IS READY",
                            style: headingStyle.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "14 Items",
                            style: contentStyle.copyWith(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                      Text(
                        "₹200",
                        style: headingStyle.copyWith(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        iconSize: 30,
        currentIndex: 0,
        onTap: (value) => {FunctionsPage.openRelevantPage(value, context)},
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ("Home")),
          BottomNavigationBarItem(
              icon: Icon(KisaanIcondart.vegetables), label: ("Vegetables")),
          BottomNavigationBarItem(
              icon: Icon(KisaanIcondart.pear), label: ("Fruits")),
          BottomNavigationBarItem(
              icon: Icon(Icons.track_changes), label: ("Profile")),
        ],
      ),
    );
  }
}
