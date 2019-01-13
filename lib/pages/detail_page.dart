import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moil_app/pages/api_provider.dart';
import 'home_page.dart';
import 'info_page.dart';

class DetailPage extends StatefulWidget {
  String mm;

  DetailPage(this.mm);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List items = [];
  bool isLoading = true;
  ApiProvider apiProvider = ApiProvider();

  Future fetchData() async {
    try {
      var response = await apiProvider.getDataScore(widget.mm);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
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
        title: Text("ข้อมูลรายวัน"),
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

                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, top: 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ListTile(
                            title: Text("${item['month']}"),
                            leading: Icon(
                              Icons.keyboard_tab,
                              color: Colors.red,
                            ),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Text(
                                item['price'],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: items != null ? items.length : 0,
                  ),
          ))
        ],
      ),
    );
  }
}
