import 'package:flutter/material.dart';
import 'package:kisaan/HomePage/OrderPage.dart';
import 'package:kisaan/HomePage/PaymentPage.dart';
import 'StyleScheme.dart';

class SelectAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectAddress(),
    );
  }
}

class selectAddress extends StatefulWidget {
  @override
  _selectAddressState createState() => _selectAddressState();
}

class _selectAddressState extends State<selectAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Select Address",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              "",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Bill Total",
                      style: headingStyle,
                    ),
                    Text(
                      "7 Items",
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
            //InkWell(
            //  onTap: () {
            //    Navigator.push(
            //        context, MaterialPageRoute(builder: (context) => MyApp));
            //  },
            //  child: Container(
            //      padding: EdgeInsets.all(20),
            //      height: 70,
            //      decoration: BoxDecoration(
            //        gradient: gradientStyle,
            //      ),
            //      child: Center(
            //        child: Text(
            //          "MAKE PAYMENT",
            //          style: TextStyle(
            //              color: Colors.white,
            //              fontSize: 22,
            //              fontWeight: FontWeight.w700),
            //        ),
            //      )),
            //),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
