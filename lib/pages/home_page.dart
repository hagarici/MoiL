import 'package:flutter/material.dart';
import 'package:moil_app/pages/info_page.dart';
import 'package:moil_app/pages/api_provider.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จ่ายค่าน้ำมัน'),
      ),
      body: new MainListView(),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff344955),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }),
            IconButton(
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => InfoPage()));
                }),
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () => exit(0),
            ),
          ],
        ),
      ),
    );
  }
}

class MainListView extends StatelessWidget {
  ApiProvider apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    Future<void> showMessage(int price) async {
      try {
        var response = await apiProvider.doSave(price);
        if (response.statusCode == 200) {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('ค่าน้ำมัน  $price '),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'ปิด',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (error) {
        print(error);
      }
    }

    // TODO: implement build
    return ListView(
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.all(5.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              new Text(
//                "จ่ายค่าน้ำมัน",
//                style: new TextStyle(
//                  fontSize: 25.0,
//                  fontWeight: FontWeight.w200,
//                ),
//              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                      child: new Container(
                        height: 200.0,
                        child: Column(
                          children: <Widget>[
                            new Expanded(
                              child: GestureDetector(
                                onTap: () => showMessage(300),
                                child: new Container(
                                  margin: new EdgeInsets.only(
                                      top: 15, bottom: 2, right: 15),
                                  decoration: new BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          new BorderRadius.circular(5.0)),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: new Icon(
                                          Icons.attach_money,
                                          color: Colors.white,
                                        ),
                                      ),
                                      new Text(
                                        '300',
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            new Expanded(
                              child: GestureDetector(
                                onTap: () => showMessage(800),
                                child: new Container(
                                  margin: new EdgeInsets.only(
                                      top: 15, bottom: 2, right: 15),
                                  decoration: new BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius:
                                          new BorderRadius.circular(5.0)),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: new Icon(
                                          Icons.attach_money,
                                          color: Colors.white,
                                        ),
                                      ),
                                      new Text(
                                        '800',
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w200),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: new Container(
                        height: 200.0,
                        child: Column(
                          children: <Widget>[
                            new Expanded(
                              child: GestureDetector(
                                onTap: () => showMessage(500),
                                child: new Container(
                                  margin: new EdgeInsets.only(
                                      top: 15, bottom: 2, right: 15),
                                  decoration: new BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius:
                                          new BorderRadius.circular(5.0)),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        '500',
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w200),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: new Icon(
                                          Icons.monetization_on,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            new Expanded(
                              child: GestureDetector(
                                onTap: () => showMessage(1000),
                                child: new Container(
                                  margin: new EdgeInsets.only(
                                      top: 15, bottom: 2, right: 15),
                                  decoration: new BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius:
                                          new BorderRadius.circular(5.0)),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        '1000',
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w200),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: new Icon(
                                          Icons.monetization_on,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
