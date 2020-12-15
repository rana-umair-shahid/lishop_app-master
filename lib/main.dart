import 'package:flutter/material.dart';
import 'package:lishop_app/constants/lishop_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiShop',
      theme: ThemeData(
        primarySwatch: LiShopColors.themeColor,
       visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'LiShop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
    );
  }
}
