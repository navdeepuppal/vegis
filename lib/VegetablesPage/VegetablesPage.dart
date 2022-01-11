import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kisaan/ExtrasPage/Functions.dart';
import 'package:kisaan/ExtrasPage/StyleScheme.dart';
import 'package:kisaan/ExtrasPage/widget/search_widget.dart';
import 'package:kisaan/FruitsPage/FruitsPage.dart';
import 'package:kisaan/HomePage/HomePage.dart';
import 'package:kisaan/ExtrasPage/feedback_model.dart';
import 'package:kisaan/ExtrasPage/kisaan_icondart_icons.dart';

class VegetablesPage extends StatefulWidget {
  @override
  _VegetablesPageState createState() => _VegetablesPageState();
}

class _VegetablesPageState extends State<VegetablesPage> {
  List<FeedbackModel> feedbacks = List<FeedbackModel>();
  List<FeedbackModel> allFeedbacks = List<FeedbackModel>();
  String query = '';
  List storedocs = [];
  int totalPrice = 0;
  int totalQuantity = 0;
  final Stream<QuerySnapshot> vegetablesStream =
      FirebaseFirestore.instance.collection('vegetables').snapshots();

  CollectionReference vegetables =
      FirebaseFirestore.instance.collection('vegetables');

  // For Deleting User
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return vegetables
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  Future<void> changeValue(id, newValue) {
    if (newValue >= 0)
      return vegetables
          .doc(id)
          .update({'quantity': newValue})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    return vegetables
        .doc(id)
        .update({'quantity': 0})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  getFeedbackFromSheet() async {
    /*  var raw = await http.get(
        "https://script.google.com/macros/s/AKfycbzemGXwGQrERCg2rpSjY9rOmNFJiOacMCUg84IBuqheKpoYjykbVdUsLAPZa--HsF2VKg/exec");

    var jsonFeedback = convert.jsonDecode(raw.body);
    print('this is json Feedback $jsonFeedback');

    // feedbacks = jsonFeedback.map((json) => FeedbackModel.fromJson(json));

    jsonFeedback.forEach((element) {
      print('$element THIS IS NEXT>>>>>>>');
      FeedbackModel feedbackModel = new FeedbackModel();
      feedbackModel.name = element['name'];

      allFeedbacks.add(feedbackModel);
    });
    */
    allFeedbacks = List<FeedbackModel>();

    for (var i = 0; i < storedocs.length; i++) {
      FeedbackModel feedbackModel = new FeedbackModel();
      feedbackModel.name = storedocs[i]['name'];
      allFeedbacks.add(feedbackModel);
    }
    feedbacks = allFeedbacks;
    //setState(() {});
    //print('${feedbacks[0]}');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: vegetablesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print('Something went Wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        storedocs = [];
        totalPrice = 0;
        totalQuantity = 0;
        snapshot.data.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          storedocs.add(a);
          a['id'] = document.id;
          if (a['quantity'] > 0) totalQuantity += 1;
          totalPrice += a['price'] * a['quantity'];
        }).toList();
        //getFeedbackFromSheet();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            title: Text(
              "Select Vegetables",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Stack(
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FruitsPage())),
                      },
                      color: Colors.red[200],
                      elevation: 4,
                      child: Text(
                        'Add Fruits ▶ ',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                                FontWeight.w900 // insert your font size here
                            ),
                        textAlign: TextAlign.center,
                      ),
                      padding: const EdgeInsets.all(2),
                      textColor: Colors.white,
                      splashColor: Colors.yellow[200],
                    ),
                  ],
                ),
              ]),

              //Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              //  children: [
              //    ElevatedButton(
              //      onPressed: () {
              //        Navigator.push(
              //            context,
              //            MaterialPageRoute(
              //                builder: (context) => FruitsPage()));
              //      },
              //      style: ButtonStyle(
              //        padding: MaterialStateProperty.all(EdgeInsets.all(5)),
              //        backgroundColor: MaterialStateProperty.all(Colors.pink),
              //        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //          RoundedRectangleBorder(
              //            borderRadius: BorderRadius.circular(10.0),
              //            side: BorderSide(color: Colors.red),
              //          ),
              //        ),
              //      ),
              //      child: Text(
              //        "Order Fruits >",
              //        textAlign: TextAlign.center,
              //        style: TextStyle(
              //          fontSize: 12,
              //          color: Colors.white,
              //        ),
              //      ),
              //    ),
              //  ],
              //),
            ],
          ),
          body: Container(
            child: Column(
              children: [
                //buildSearch(),
                Expanded(
                  child: ListView.builder(
                    itemCount: storedocs.length,
                    itemBuilder: (context, index) {
                      return buildFeedback(
                        index + 1,
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: gradientStyleBlue,
                  ),
                  padding: EdgeInsets.all(6),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Vegetables Basket",
                              style: headingStyle.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "${totalQuantity} Items added",
                              style: contentStyle.copyWith(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "₹${totalPrice}",
                          style: headingStyle.copyWith(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            iconSize: 30,
            currentIndex: 1,
            onTap: (value) => {FunctionsPage.openRelevantPage(value, context)},
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("Home")),
              BottomNavigationBarItem(
                  icon: Icon(KisaanIcondart.vegetables),
                  title: Text("Vegetables")),
              BottomNavigationBarItem(
                  icon: Icon(KisaanIcondart.pear), title: Text("Fruits")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.track_changes), title: Text("Profile")),
            ],
          ),
        );
      },
    );
  }

  //Search
  Widget buildSearch() {
    return SearchWidget(
      text: query,
      hintText: 'Title or Author Name',
      onChanged: searchBook,
    );
  }

  void searchBook(String query) {
    final feedbacks = allFeedbacks.where((feedback) {
      final nameLower = feedback.name.toLowerCase();
      print(nameLower);
      //final authorLower = feedback.author.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(
              searchLower) /* ||
          authorLower.contains(searchLower)*/
          ;
    }).toList();

    setState(() {
      this.query = query;
      this.feedbacks = feedbacks;
    });
  }

  /*
}

class FeedbackTile extends StatelessWidget {
  final String name;
  final int index;
  FeedbackTile({this.name, this.index});

  @override
  Widget build(BuildContext context) {
    //return Container(
    //  padding: EdgeInsets.all(16),
    //  child: Column(
    //    crossAxisAlignment: CrossAxisAlignment.start,
    //    children: [
    //      Row(
    //        children: [
    //          Container(
    //              height: 40,
    //              width: 40,
    //              child: ClipRRect(
    //                  borderRadius: BorderRadius.all(Radius.circular(40)),
    //                  child: Image.network(name))),
    //          SizedBox(width: 16),
    //          Column(
    //            crossAxisAlignment: CrossAxisAlignment.start,
    //            children: [
    //              Text(name),
    //              Text(
    //                'from $name',
    //                style: TextStyle(color: Colors.grey),
    //              )
    //            ],
    //          )
    //        ],
    //      ),
    //      SizedBox(height: 16),
    //      Text(name)
    //    ],
    //  ),
    //);
*/

  Widget buildFeedback(i) {
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
                Image.network(
                  storedocs[i - 1]['img'],
                  height: 40,
                  width: 40,
                  isAntiAlias: true,
                  colorBlendMode: BlendMode.color,
                ),
                //Container(
                //  margin: EdgeInsets.all(6.5),
                //  height: 37,
                //  width: 30,
                //  decoration: BoxDecoration(
                //    image: DecorationImage(
                //      image: AssetImage('asset/images/cloth$i.png'),
                //    ),
                //  ),
                //),
                Container(
                  width: 165,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        storedocs[i - 1]['name'],
                        style: contentStyle.copyWith(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      //Text(
                      //  "\$$price",
                      //  style: headingStyle.copyWith(color: Colors.grey),
                      //),

                      Text(
                        storedocs[i - 1]['units'],
                        style: contentStyle.copyWith(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '₹' + storedocs[i - 1]['price'].toString(),
                      style: contentStyle.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //Text(
                    //  "\$$price",
                    //  style: headingStyle.copyWith(color: Colors.grey),
                    //),

                    Text(
                      "₹" + storedocs[i - 1]['note'],
                      style: contentStyle.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          gradient: gradientStyle, shape: BoxShape.circle),
                      child: Center(
                        //Minus Button
                        child: IconButton(
                          onPressed: () {
                            int newValue = storedocs[i - 1]['quantity'] - 1;
                            changeValue(storedocs[i - 1]['id'], newValue);
                            if (newValue >= 0)
                              storedocs[i - 1]['quantity'] = newValue;
                          },
                          icon: Text(
                            "-",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: (15),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      child: Center(
                        child: Text(storedocs[i - 1]['quantity'].toString(),
                            style: headingStyle.copyWith(fontSize: 22)),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          gradient: gradientStyle, shape: BoxShape.circle),
                      child: Center(
                        //Plus Button
                        child: IconButton(
                          onPressed: () {
                            int newValue = storedocs[i - 1]['quantity'] + 1;
                            changeValue(storedocs[i - 1]['id'], newValue);
                            if (newValue >= 0)
                              storedocs[i - 1]['quantity'] = newValue;
                          },
                          icon: Text(
                            "+",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: (15),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
}
