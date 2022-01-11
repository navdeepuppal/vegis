import 'package:flutter/material.dart';
import 'package:kisaan/FruitsPage/FruitsPage.dart';
import 'package:kisaan/VegetablesPage/VegetablesPage.dart';
import '../HomePage/HomePage.dart';
import '../ProfilePage/ProfilePage.dart';

class FunctionsPage extends StatelessWidget {
  int totalPrice;
  int totalQuantity;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: functionsPage(),
    );
  }

  static void openRelevantPage(int pageId, BuildContext context) {
    FunctionsPage hp = new FunctionsPage();
    hp.openRelevantPageHelper(pageId, context);
  }

  void openRelevantPageHelper(int pageId, BuildContext context) {
    switch (pageId) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => VegetablesPage()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FruitsPage()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
        break;
      default:
    }
  }
}

class functionsPage extends StatefulWidget {
  @override
  _functionsPageState createState() => _functionsPageState();
}

// ignore: camel_case_types
class _functionsPageState extends State<functionsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
