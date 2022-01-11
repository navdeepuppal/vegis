import 'package:flutter/material.dart';
import 'package:kisaan/FruitsPage/FruitsPage.dart';
import 'package:kisaan/HomePage/HomePage.dart';
import 'package:kisaan/ProfilePage/LoginPage.dart';
import 'package:kisaan/ProfilePage/LoginPage_Sqflite.dart';
import 'package:kisaan/HomePage/OrderConfirmed.dart';
import 'package:kisaan/ExtrasPage/PickUpTimePage.dart';
import 'package:kisaan/ExtrasPage/StyleScheme.dart';
import 'package:kisaan/ProfilePage/Login_Sqflite.dart';
import 'package:kisaan/HomePage/PaymentPage.dart';
import 'package:kisaan/ExtrasPage/selectAddress.dart';
import 'package:kisaan/ProfilePage/database_connector.dart';
import 'package:kisaan/VegetablesPage/VegetablesPage.dart';
import 'package:sqflite/sqflite.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: orderPage(),
    );
  }
}

class orderPage extends StatefulWidget {
  @override
  _orderPageState createState() => _orderPageState();
}

class _orderPageState extends State<orderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text(
          "Confirm Your Order",
          style: TextStyle(
              color: Colors.black, fontSize: 17.5, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center,
              //children: [
              //  ElevatedButton(
              //    onPressed: () {
              //      Navigator.push(context,
              //          MaterialPageRoute(builder: (context) => FruitsPage()));
              //    },
              //    style: ButtonStyle(
              //      padding: MaterialStateProperty.all(EdgeInsets.all(3)),
              //      backgroundColor: MaterialStateProperty.all(Colors.pink),
              //      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //        RoundedRectangleBorder(
              //          borderRadius: BorderRadius.circular(7.0),
              //          side: BorderSide(color: Colors.red),
              //        ),
              //      ),
              //    ),
              //    child: Text(
              //      "Add Fruits Also >",
              //      textAlign: TextAlign.center,
              //      style: TextStyle(
              //        fontSize: 12,
              //        color: Colors.white,
              //      ),
              //    ),
              //  ),
              //  ElevatedButton(
              //    onPressed: () {
              //      Navigator.push(context,
              //          MaterialPageRoute(builder: (context) => FruitsPage()));
              //    },
              //    style: ButtonStyle(
              //      padding: MaterialStateProperty.all(EdgeInsets.all(3)),
              //      backgroundColor: MaterialStateProperty.all(Colors.pink),
              //      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //        RoundedRectangleBorder(
              //          borderRadius: BorderRadius.circular(7.0),
              //          side: BorderSide(color: Colors.red),
              //        ),
              //      ),
              //    ),
              //    child: Text(
              //      "Add Fruits Also >",
              //      textAlign: TextAlign.center,
              //      style: TextStyle(
              //        fontSize: 12,
              //        color: Colors.white,
              //      ),
              //    ),
              //  ),
              //],
              children: [
                Stack(
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FruitsPage())),
                      },
                      color: Colors.greenAccent.shade400,
                      elevation: 4,
                      child: Text(
                        'Order Fruits \nAlso',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                                FontWeight.w900 // insert your font size here
                            ),
                        textAlign: TextAlign.center,
                      ),
                      padding: const EdgeInsets.all(2),
                      textColor: Colors.white,
                      splashColor: Colors.redAccent,
                    ),
                    MaterialButton(
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VegetablesPage())),
                      },
                      color: Colors.lightGreen[600],
                      elevation: 4,
                      child: Text(
                        'Order Vegetables \nAlso',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                                FontWeight.w900 // insert your font size here
                            ),
                        textAlign: TextAlign.center,
                      ),
                      padding: const EdgeInsets.all(2),
                      textColor: Colors.white,
                      splashColor: Colors.redAccent,
                    ),
                  ],
                ),
              ]),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    clothWidget("cloth1", "Trouser", "15"),
                    clothWidget("cloth2", "Jeans", "10"),
                    clothWidget("cloth3", "Jackets", "15"),
                    clothWidget("cloth4", "Shirt", "5"),
                    clothWidget("cloth5", "T-Shirt", "7"),
                    clothWidget("cloth6", "Blazer", "50"),
                    clothWidget("cloth7", "Coats", "40"),
                    clothWidget("cloth8", "Kurta", "15"),
                    clothWidget("cloth9", "Sweater", "17")
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Your Basket",
                      style: headingStyle,
                    ),
                    Text(
                      "7 Items added",
                      style: contentStyle,
                    )
                  ],
                ),
                Text(
                  "\$200",
                  style: headingStyle,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                DatabaseConnect con = DatabaseConnect();
                final Future<Database> dbFuture = con.initializeDatabase();
                dbFuture.then((database) {
                  Future<List<Map<String, dynamic>>> noteListFuture =
                      con.getList();
                  noteListFuture.then((emp_data) {
                    if (emp_data.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CODPayment()));
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => insertPage(id: 0)),
                      );
                    }
                  });
                });
              },
              child: Container(
                  padding: EdgeInsets.all(20),
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: gradientStyle,
                  ),
                  child: Center(
                    child: Text(
                      "PROCEED",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  )),
            ),
            SizedBox(
              height: 2,
            )
          ],
        ),
      ),
    );
  }

  Container clothWidget(String img, String name, String price) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
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
                      style: headingStyle,
                    ),
                    Text(
                      "\$$price",
                      style: headingStyle.copyWith(color: Colors.grey),
                    ),
                    Text(
                      "Add Note",
                      style: contentStyle.copyWith(color: Colors.blue),
                    )
                  ],
                ),
                Text(
                  "\$45",
                  style: headingStyle,
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          gradient: gradientStyle, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          "-",
                          style: headingStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: Center(
                        child: Text("1",
                            style: headingStyle.copyWith(fontSize: 30)),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          gradient: gradientStyle, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          "+",
                          style: headingStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.75,
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
    );
  }

  Column categoryWidget(String img, String name, bool isActive) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: (isActive) ? null : Colors.grey.withOpacity(0.3),
            gradient: (isActive) ? gradientStyle : null,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/images/$img.png'),
                      fit: BoxFit.contain)),
            ),
          ),
        ),
        Text(name, style: headingStyle)
      ],
    );
  }
}
