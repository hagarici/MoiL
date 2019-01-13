import 'package:flutter/material.dart';
import 'package:moil_app/pages/home_page.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //   ปิด  debug
      theme: ThemeData(
          fontFamily: 'Athiti',
          scaffoldBackgroundColor: Color(0xffe9ebee),
          primaryColor: Color(0xff344955),
          accentColor: Color(0xfff9aa33)),
      title: 'MoiL',
      home: HomePage(),
    );
  }
}
