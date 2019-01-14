import 'package:flutter/material.dart';
import 'package:flutter_appbar/pages/HomeItemPage.dart';

///
/// @author songyaru
/// @date 2019/1/14
///
class MinePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Widget _tabBarItem(String title, {bool showRightImage = true}) {
  return Tab(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Expanded(
        child: Center(
          child: Text(title),
        ),
      ),

      ///分割符自定义，可以放任何widget
      showRightImage
          ? Container(
              width: 1,
              margin: EdgeInsets.only(top: 15, bottom: 15),
              color: Colors.red,
            )
          : Container(
              width: 1,
              margin: EdgeInsets.only(top: 15, bottom: 15),
            )
    ],
  ));
}

class _HomePageState extends State<MinePage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<MinePage> {
  TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    _tabBarItem('主页'),
    _tabBarItem('每日更新'),
    _tabBarItem('专栏'),
    _tabBarItem('公开课', showRightImage: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, initialIndex: 0, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TabBar(
            labelPadding: EdgeInsets.all(0),
            tabs: myTabs,
            controller: _tabController,
            isScrollable: false,
            labelColor: Colors.black,
            indicatorColor: Color(0xFFF8A120),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,

            /// 简单暴力的解决办法，左右间距根据上边间隔符的大小决定
            indicatorPadding: EdgeInsets.only(left: 15, bottom: 0.5, right: 15),
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Expanded(
              child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: _tabController,
                  children: <Widget>[
                HomeItemPage(),
                HomeItemPage(),
                HomeItemPage(),
                HomeItemPage(),
              ])),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
