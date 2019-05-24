import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appbar/pages/CartPage.dart';
import 'package:flutter_appbar/pages/CategoryPage.dart';
import 'package:flutter_appbar/pages/FindPage.dart';
import 'package:flutter_appbar/pages/HomePage.dart';
import 'package:flutter_appbar/pages/MinePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appbar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;

  var _tabIcons = [
    Icon(Icons.home),
    Icon(Icons.find_in_page),
    Icon(Icons.calendar_today),
    Icon(Icons.shopping_cart),
    Icon(Icons.account_box)
  ];

  var _body;
  var _appBarTitles = ['首页', '发现', '分类', '购物车', '我'];

  Image getTabImage(path) {
    return new Image.asset(path, width: 25, height: 25);
  }

  void initData() {
    _body = new IndexedStack(
      children: <Widget>[
        SafeArea(top: true, child: MinePage()),
        SafeArea(
          top: true,
          child: HomePage(),
        ),
        SafeArea(
          top: true,
          child: CategoryPage(),
        ),
        SafeArea(
          top: true,
          child: CartPage(),
        ),
        SafeArea(
          top: true,
          child: FindPage(),
        ),
      ],
      index: _tabIndex,
    );
  }

  Widget _getTabTitle(int curIndex) {
    return Text(_appBarTitles[curIndex], style: TextStyle(fontSize: 14));
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      key: ObjectKey("MainPage"),
      body: _body,
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: Colors.red,
        inactiveColor: Colors.black,
        iconSize: 20,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: _tabIcons[0], title: _getTabTitle(0)),
          BottomNavigationBarItem(icon: _tabIcons[1], title: _getTabTitle(1)),
          BottomNavigationBarItem(icon: _tabIcons[2], title: _getTabTitle(2)),
          BottomNavigationBarItem(icon: _tabIcons[3], title: _getTabTitle(3)),
          BottomNavigationBarItem(icon: _tabIcons[4], title: _getTabTitle(4)),
        ],
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}
