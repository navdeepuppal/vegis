import 'package:flutter/material.dart';
import 'package:kisaan/ExtrasPage/StyleScheme.dart';
import 'Functions.dart';
import '../HomePage/HomePage.dart';

class TrackOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: trackOrderPage(),
    );
  }
}

class trackOrderPage extends StatefulWidget {
  @override
  _trackOrderPageState createState() => _trackOrderPageState();
}

class _trackOrderPageState extends State<trackOrderPage> {
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
          "Track Order",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Number 1001",
                style: headingStyle,
              ),
              Text(
                "Order confirmed. Ready to pick",
                style: contentStyle.copyWith(color: Colors.grey, fontSize: 16),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                height: 1,
                color: Colors.grey,
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 13, top: 50),
                    width: 4,
                    height: 400,
                    color: Colors.grey,
                  ),
                  Column(
                    children: [
                      statusWidget('confirmed', "Confirmed", true),
                      statusWidget('onBoard2', "Picked Up", false),
                      statusWidget('servicesImg', "In Pricess", false),
                      statusWidget('shipped', "Shipped", false),
                      statusWidget('Delivery', "Delivered", false),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                height: 1,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.blue,
                        )),
                    child: Text(
                      "Cancel Order",
                      style: contentStyle.copyWith(color: Colors.blue),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blue,
                    ),
                    child: Text(
                      "My Orders",
                      style: contentStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ],
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
              icon: Icon(Icons.track_changes), title: Text("Vegetables")),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list), title: Text("Fruits")),
          BottomNavigationBarItem(
              icon: Icon(Icons.track_changes), title: Text("Profile")),
        ],
      ),
    );
  }

  Container statusWidget(String img, String status, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isActive) ? Colors.blue : Colors.white,
                border: Border.all(
                    color: (isActive) ? Colors.transparent : Colors.blue,
                    width: 3)),
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("asset/images/$img.png"),
                        fit: BoxFit.contain)),
              ),
              Text(
                status,
                style: contentStyle.copyWith(
                    color: (isActive) ? Colors.blue : Colors.black),
              )
            ],
          )
        ],
      ),
    );
  }
}
