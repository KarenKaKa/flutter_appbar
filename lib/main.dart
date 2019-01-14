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
  final tabTextStyleNormal = new TextStyle(color: Colors.black, fontSize: 13);
  final tabTextStyleSelected =
      new TextStyle(color: const Color(0xffFCAD31), fontSize: 13);

  var tabImages = [
    [
      Image.asset('images/home.png', width: 25, height: 25),
      Image.asset('images/home_selected.png', width: 25, height: 25)
    ],
    [
      Image.asset(
        'images/find.png',
        width: 25,
        height: 25,
        color: Colors.black,
      ),
      Image.asset('images/find_selected.png', width: 25, height: 25),
    ],
    [
      Image.asset('images/category.png', width: 25, height: 25),
      Image.asset('images/category_selected.png', width: 25, height: 25),
    ],
    [
      Image.asset('images/cart.png', width: 25, height: 25),
      Image.asset('images/cart_selected.png', width: 25, height: 25),
    ],
    [
      Image.asset('images/mine.png', width: 25, height: 25),
      Image.asset('images/mine_selected.png', width: 25, height: 25),
    ]
  ];

  var _body;
  var appBarTitles = ['首页', '发现', '分类', '购物车', '我'];

  Image getTabImage(path) {
    return new Image.asset(path, width: 25, height: 25);
  }

  void initData() {
    _body = new IndexedStack(
      children: <Widget>[
        SafeArea(top: true, child: HomePage()),
        SafeArea(
          top: true,
          child: FindPage(),
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
          child: MinePage(),
        ),
      ],
      index: _tabIndex,
    );
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  Text getTabTitle(int curIndex) {
    return Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      key: ObjectKey("MainPage"),
      body: _body,
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
          BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
          BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
          BottomNavigationBarItem(icon: getTabIcon(3), title: getTabTitle(3)),
          BottomNavigationBarItem(icon: getTabIcon(4), title: getTabTitle(4)),
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
