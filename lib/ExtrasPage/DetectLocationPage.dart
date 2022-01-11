import 'package:flutter/material.dart';
import '../HomePage/HomePage.dart';
import 'StyleScheme.dart';

class DetectLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: detectLocationPage(),
    );
  }
}

class detectLocationPage extends StatefulWidget {
  @override
  _detectLocationPageState createState() => _detectLocationPageState();
}

class _detectLocationPageState extends State<detectLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage('asset/images/bg.png'))),
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/images/shipped.png'))),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Delivery Location",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Text(
                  "Enter your full delivery address on which you want to deliever",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          Positioned(
            bottom: 200,
            left: 20,
            right: 20,
            child: Column(children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Full Address",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "PinCode",
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: gradientStyle,
                      //color: Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        "Done",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    )),
              ),

              //InkWell(
              //  onTap: () {},
              //  child: Container(
              //      padding: EdgeInsets.all(10),
              //      height: 50,
              //      decoration: BoxDecoration(
              //        color: Colors.transparent,
              //      ),
              //      child: Center(
              //        child: Text(
              //          "Set location manually",
              //          style: TextStyle(
              //              color: Colors.orange,
              //              fontSize: 17,
              //              fontWeight: FontWeight.w600),
              //        ),
              //      )),
              //),
            ]),
          ),
        ],
      ),
    );
  }
}
