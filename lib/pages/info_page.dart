import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:moil_app/pages/api_provider.dart';
import 'package:moil_app/pages/detail_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'home_page.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List items = [];
  bool isLoading = true;
  int total = 0;
  ApiProvider apiProvider = ApiProvider();

  Future fetchData() async {
    try {
      var response = await apiProvider.getData();

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        setState(() {
          isLoading = false;
          items = jsonResponse;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สรุปค่าน้ำมัน"),
      ),
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
      body: Column(
        children: <Widget>[
          Expanded(
              child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      var item = items[index];
                      total = total + int.parse(item['price']);
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ListTile(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPage(item['mm'])));
                              },
                              title: Text(
                                  "${item['name']}                       ยอดรวม  $total"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              leading: CircularPercentIndicator(
                                radius: 50.0,
                                lineWidth: 10.0,
                                percent: double.parse(item['price']) / 10000,
                                center: new Text("${item['price']}"),
                                progressColor: Colors.pink,
                              )),
                        ),
                      );
                    },
                    itemCount: items != null ? items.length : 0,
                  ),
          )),
        ],
      ),
    );
  }
}
