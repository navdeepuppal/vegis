import 'package:flutter/material.dart';
import 'package:kisaan/HomePage/HomePage.dart';
import 'package:kisaan/ProfilePage/database_connector.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../ProfilePage/Login_Sqflite.dart';

class Sqlfliteee extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SqlfliteeePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class SqlfliteeePage extends StatefulWidget {
  SqlfliteeePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SqlfliteeePageState createState() => _SqlfliteeePageState();
}

class _SqlfliteeePageState extends State<SqlfliteeePage> {
  int _counter = 0;
  List employeeFinalList;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    int id = 0;
    if (employeeFinalList == null) {
      DBConDisplay();
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
              },
            ),
          ]),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: getDynamicTable(),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => insertPage(id: id)),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Table getDynamicTable() {
    List<TableRow> rows = [];

    rows.add(TableRow(children: [
      Text("Id"),
      Text("Name "),
      Text("Address "),
      Text("Edit"),
      Text("Delete"),
    ]));

    if (employeeFinalList != null) {
      for (int i = 0; i < this.employeeFinalList.length; ++i) {
        rows.add(TableRow(children: [
          Text("" + employeeFinalList[i]['id'].toString()),
          Text("" + employeeFinalList[i]['name'].toString()),
          Text("" + employeeFinalList[i]['address'].toString()),
          new RaisedButton(
            child: new Text('ED'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        insertPage(id: int.parse(employeeFinalList[i]['id']))),
              );
            },
          ),
          new RaisedButton(
            child: new Text('DEL'),
            onPressed: () => DBConDelete(int.parse(employeeFinalList[i]['id'])),
          )
        ]));
      }
    }

    return Table(
      border: TableBorder.all(width: 2.0, color: Colors.black),
      columnWidths: {
        0: FixedColumnWidth(100.0),
        1: FlexColumnWidth(),
      },
      children: rows,
    );
  }

  void JustPrint() {
    print('wow');
  }

  void DBConDelete(int id) {
    DatabaseConnect con = DatabaseConnect();
    final Future<Database> dbFuture = con.initializeDatabase();
    dbFuture.then((database) {
      Future<int> noteListFutureDelete = con.deleteEntry(id);
      noteListFutureDelete.then((noteList) {
        DBConDisplay();
      });
    });
  }

  void DBConInsert() {
    DatabaseConnect con = DatabaseConnect();

    final Future<Database> dbFuture = con.initializeDatabase();
    dbFuture.then((database) {
      Future<int> noteListFutureInsert = con.insertStatic();
      noteListFutureInsert.then((noteList) {
        print(noteList);
      });
    });
  }

  void DBConDisplay() {
    DatabaseConnect con = DatabaseConnect();

    List<Map<String, dynamic>> list = [];
    final Future<Database> dbFuture = con.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Map<String, dynamic>>> noteListFuture = con.getList();
      noteListFuture.then((emp_data) {
        for (var i = 0; i < emp_data.length; i++) {
          Map m = emp_data[i];
          m.forEach((k, v) => print('a${k}: ${v}'));
        }
        fixOutputInRows(emp_data);
      });
    });
  }

  void fixOutputInRows(List<Map<String, dynamic>> emp_data) {
    var columns = new List();
    var rows_values = new List();
    var properDataArray = new List();
    int loop_run = 1;
    columns = [];
    rows_values = [];
    properDataArray = [];
    String first_column = "";

    for (var i = 0; i < emp_data.length; i++) {
      int col_position = 0;
      int found_all_colums = 0;
      Map m = emp_data[i];
      m.forEach((k, v) => {
            if (loop_run == 1)
              {
                first_column = '${k}',
              },
            if (loop_run > 1 && first_column == '${k}')
              {
                found_all_colums = 1,
              },
            if (found_all_colums != 1)
              {
                columns.add('${k}'),
              },
            if (loop_run == 1)
              {
                loop_run++,
              },
            rows_values.add('${v}'),
          });
    }

    var added_rows = 0;
    double total_rows = 0;
    if (columns.length > 0) {
      total_rows = (rows_values.length / columns.length) as double;
    }
//print("Total rows : "+(total_rows).toString());

    int value_get_count = 0;
    for (var i = 0; i < total_rows; i++) {
      Map temp_array = {};
      for (var j = 0; j < columns.length; j++) {
        temp_array[columns[j]] = rows_values[value_get_count];
        value_get_count++;
      }
      properDataArray.add(temp_array);
    }
    print(properDataArray);

    if (total_rows > 0) {
      setState(() {
        this.employeeFinalList = properDataArray;
      });
    }
  }
}
