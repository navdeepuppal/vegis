/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kisaan/HomePage.dart';
import 'package:kisaan/feedback_model.dart';
import 'package:kisaan/model/itemInCart.dart';
import 'package:kisaan/widget/search_widget.dart';
import 'package:sqflite/sqflite.dart';
import 'Functions.dart';
import 'StyleScheme.dart';

class FruitsPage extends StatefulWidget {
  @override
  _FruitsPageState createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> {
  List<FeedbackModel> feedbacks = List<FeedbackModel>();
  List<FeedbackModel> allFeedbacks = List<FeedbackModel>();
  String query = '';
  List storedocs = [];
  int totalPrice = 0;
  int totalQuantity = 0;
  var database = ItemInCart().main();
  final Stream<QuerySnapshot> fruitsStream =
      FirebaseFirestore.instance.collection('fruits').snapshots();

  CollectionReference fruits = FirebaseFirestore.instance.collection('fruits');
  // For Deleting User
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return fruits
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  Future<void> changeValue(database, b, newValue) async {
    if (b != null) {
      b.quantity = newValue;
      ItemInCart().updateItem(database, b);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  setBasket(Future<Database> database) async {
    print("Setting basket...");
    totalPrice = 0;
    totalQuantity = 0;
    List<ItemInCart> items = await ItemInCart().printItems(database);
    print("basket $items");
    for (int i = 0; i < items.length; i++) {
      print("basket q $totalQuantity");
      print("basket p $totalPrice");
      totalPrice += items[i].price * items[i].quantity;
      totalQuantity += items[i].quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fruitsStream,
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
        var items;
        snapshot.data.docs.map((DocumentSnapshot document) async {
          items = await ItemInCart().printItems(database);
          var db = database;
          Map a = document.data() as Map<String, dynamic>;
          storedocs.add(a);
          a['id'] = document.id;
          var b = ItemInCart(
            itemId: a['id'],
            itemName: a['name'],
            price: a['price'],
            quantity: 0,
          );
          if (ItemInCart().findItem(database, b.itemId) == null)
            ItemInCart().insertItem(db, b);
          setBasket(db);
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
              "Select Fruits",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.black,
                onPressed: () {},
              )
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
                        items,
                        index + 1,
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () => HomePage(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Your Basket",
                              style: headingStyle.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "$totalQuantity Items added",
                              style: contentStyle.copyWith(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "₹$totalPrice",
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
            currentIndex: 2,
            onTap: (value) => {FunctionsPage.openRelevantPage(value, context)},
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("Home")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.track_changes), title: Text("Vegetables")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.view_list), title: Text("Fruits")),
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
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.feedbacks = feedbacks;
    });
  }

  Widget buildFeedback(items, i) {
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
                      image: AssetImage('asset/images/cloth$i.png'),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storedocs[i - 1]['name'],
                      style: headingStyle,
                    ),
                    Text(
                      storedocs[i - 1]['note'],
                      style: contentStyle.copyWith(color: Colors.blue),
                    )
                  ],
                ),
                Text(
                  storedocs[i - 1]['price'].toString(),
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
                        //Minus Button
                        child: IconButton(
                          onPressed: () {
                            int newValue = items[i - 1].quantity - 1;
                            changeValue(database, items[i - 1], newValue);
                          },
                          icon: Text(
                            "-",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: (20),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: Center(
                        child: Text(items[i - 1].quantity.toString(),
                            style: headingStyle.copyWith(fontSize: 30)),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          gradient: gradientStyle, shape: BoxShape.circle),
                      child: Center(
                        //Plus Button
                        child: IconButton(
                          onPressed: () {
                            int newValue = storedocs[i - 1]['quantity'] + 1;
                            changeValue(
                                database, storedocs[i - 1]['itemId'], newValue);
                          },
                          icon: Text(
                            "+",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: (20),
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
}
*/