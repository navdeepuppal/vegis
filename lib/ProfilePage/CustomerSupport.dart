import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WhatsApp(),
  ));
}

class WhatsApp extends StatefulWidget {
  const WhatsApp({Key key}) : super(key: key);

  @override
  _WhatsAppState createState() => _WhatsAppState();
}

class _WhatsAppState extends State<WhatsApp> {
  var phone = "";
  var msg = "";
  var code = "+91";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don\'t Worry! We are here to help you.. 😊",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  msg = value;
                },
                decoration: InputDecoration(
                    fillColor: Colors.teal,
                    focusColor: Colors.teal,
                    hoverColor: Colors.teal,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Please describe your issue"),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                borderRadius: BorderRadius.circular(20),
                color: Colors.teal,
                elevation: 5,
                child: MaterialButton(
                  child: const Text(
                    'Send',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    // https://wa.me/1XXXXXXXXXX?text=I'm%20interested%20in%20your%20car%20for%20sale
                    phone = '9041504403';
                    if (phone.length < 10) {
                      Fluttertoast.showToast(
                          msg: "Enter a valid phone number",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          webPosition: "center",
                          fontSize: 16.0);
                    } else {
                      code = code.replaceAll("+", "");

                      var url = "https://wa.me/$code$phone?text=$msg";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw "Could not launch $url";
                      }
                      // print(code);
                    }
                  },
                  minWidth: 130,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
