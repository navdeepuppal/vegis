import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kisaan/HomePage/OrderConfirmed.dart';
import 'package:kisaan/HomePage/OrderPage.dart';
import 'package:kisaan/ExtrasPage/StyleScheme.dart';
import 'package:intl/intl.dart';
import 'package:kisaan/HomePage/upi_payPage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(CODPayment());

class CODPayment extends StatefulWidget {
  @override
  _CODPaymentState createState() => _CODPaymentState();
}

class _CODPaymentState extends State<CODPayment> {
  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    //return MaterialApp(
    //  home: Scaffold(
    //    appBar: AppBar(
    //      title: const Text('Razorpay Sample App'),
    //    ),
    //    body: Center(
    //        child: Row(
    //            mainAxisAlignment: MainAxisAlignment.center,
    //            children: <Widget>[
    //          RaisedButton(onPressed: openCheckout, child: Text('Pay via RazorPay'))
    //        ])),
    //  ),
    //);
    final _dbRef = FirebaseDatabase.instance.reference();
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
        title: Text(
          "MAKE PAYMENT",
          style: TextStyle(
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Delievery Address: #ADDRESS#",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 90,
                    ),
                    Text(
                      "Choose Preferred Payment Method :",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        DateFormat dateFormat3 = DateFormat('yy MM dd');
                        var tableRef =
                            _dbRef.child(dateFormat3.format(DateTime.now()));
                        int phoneNo = 9041504403;
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

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderConfirmPage()));

                        return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("Order Placed 😊"),
                            content: Text(
                                "Your order has been successfully placed !"),
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
                      child: Column(
                        children: [
                          Text(
                            'Cash on Delivery',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            'Recommended',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //   ElevatedButton(
                    //       onPressed: () async {
                    //         _dbRef.once().then((DataSnapshot snapshot) {
                    //           /*
                    //           // Getting LatestOrderID from RealtimeDatabase
                    //           String data = snapshot.value.toString();
                    //           int index = data.indexOf("LatestOrderID");
                    //           if (index > -1) {
                    //             int index2;
                    //             for (int i = index; i < data.length; i++) {
                    //               if (data[i] == ",") {
                    //                 index2 = i;
                    //                 break;
                    //               }
                    //             }
                    //             latestOrderID =
                    //                 int.parse(data.substring(index + 15, index2));
                    //
                    //             print("LatestOrderID $latestOrderID");
                    //           }
                    //           */
                    //         });
                    //       },
                    //       child: const Text("Load Data")),
                    /*ElevatedButton(
                        onPressed: () async {
                          var tableRef = _dbRef.child("Sheet1");
                          int phoneNo = 9041504403;
                          DateFormat dateFormat = DateFormat('yy-MM-dd HH:mm');
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
                            'Timestamp': DateTime.now().toString(),
                            'TrackStatus': "Deievered"
                          });
                          tableRef.push();
                        },
                        child: const Text("Update Data"),
                        ),*/
                    SizedBox(
                      height: 10,
                    ),
                    //ElevatedButton(
                    //  onPressed: () {
                    //    String upi_url =
                    //        'upi://pay?pa=navdeepuppal1609-1@okaxis&pn=Navdeep Singh&tn=Pay Total Amount for Confirming Order&cu=INR';
                    //  },
                    //  child: Text(
                    //    'Pay via RazorPay',
                    //    style: TextStyle(
                    //      fontSize: 22,
                    //    ),
                    //  ),
                    //),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UPI_Page()));
                      },
                      child: Text(
                        'Pay via UPI',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    //ElevatedButton(
                    //  onPressed: () {
                    //    // Navigator.push(
                    //    //     context,
                    //    //     MaterialPageRoute(
                    //    //         builder: (context) => UpiApp()));
                    //  },
                    //  child: Text(
                    //    'Pay via RazorPay',
                    //    style: TextStyle(
                    //      fontSize: 22,
                    //    ),
                    //  ),
                    //),

                    Text(
                      "You can also pay using GOOGLE PAY/PAYTM to the delievery boy when you choose COD as Payment Option. \n\n\n Note: If you want to cancel Order, then Goto Cutomer Support in Profile Page Section",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
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
                      "BILL TOTAL: ",
                      style: headingStyle,
                    ),
                    Text(
                      "7 Items",
                      style: contentStyle,
                    )
                  ],
                ),
                Text(
                  "Rs. 2000",
                  style: headingStyle,
                )
              ],
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(20),
                height: 5,
                decoration: BoxDecoration(
                  gradient: gradientStyle,
                ),
                child: Center(
                  child: Text(
                    "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_aJlz27ThdTeblZ',
      'amount': 100,
      'name': 'kisaan',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }
}
