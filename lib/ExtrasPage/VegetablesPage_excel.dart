import 'package:flutter/material.dart';
import 'package:kisaan/ExtrasPage/widget/search_widget.dart';
import 'package:kisaan/HomePage/HomePage.dart';
import 'package:kisaan/ExtrasPage/feedback_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'Functions.dart';
import 'StyleScheme.dart';

class VegetablesPage_excel extends StatefulWidget {
  @override
  _VegetablesPageState createState() => _VegetablesPageState();
}

class _VegetablesPageState extends State<VegetablesPage_excel> {
  List<FeedbackModel> feedbacks = List<FeedbackModel>();
  List<FeedbackModel> allFeedbacks = List<FeedbackModel>();
  String query = '';

  getFeedbackFromSheet() async {
    var raw = await http.get(
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
    setState(() {});
    //print('${feedbacks[0]}');
  }

  @override
  void initState() {
    getFeedbackFromSheet();
    super.initState();
    feedbacks = allFeedbacks;
  }

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
          "Select Vegetables",
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
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: feedbacks.length,
                itemBuilder: (context, index) {
                  return FeedbackTile(
                    name: feedbacks[index].name,
                    index: index + 1,
                  );
                },
              ),
            ),
            Container(
              color: Colors.green,
              padding: EdgeInsets.all(10),
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
                        "7 Items added",
                        style: contentStyle.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "\$200",
                    style: headingStyle.copyWith(
                      color: Colors.white,
                    ),
                  )
                ],
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
      final titleLower = feedback.name.toLowerCase();
      //final authorLower = feedback.author.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(
              searchLower) /* ||
          authorLower.contains(searchLower)*/
          ;
    }).toList();

    setState(() {
      this.query = query;
      this.feedbacks = feedbacks;
    });
  }
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
                      image: AssetImage('asset/images/cloth$index.png'),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$name",
                      style: headingStyle,
                    ),
                    //Text(
                    //  "\$$price",
                    //  style: headingStyle.copyWith(color: Colors.grey),
                    //),
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
}
