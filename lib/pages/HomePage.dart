import 'package:flutter/material.dart';

///
/// @author songyaru
/// @date 2019/1/14
///
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Widget _timeTabBarItem(String title) {
  return Tab(
      child: Text(
    title,
    style: TextStyle(color: Colors.white, fontSize: 18),
  ));
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _timeTabController;
  List<Tab> timeTabs = <Tab>[
    _timeTabBarItem("10:00"),
    _timeTabBarItem("13:00"),
    _timeTabBarItem("15:00"),
    _timeTabBarItem("17:00"),
    _timeTabBarItem("19:00"),
    _timeTabBarItem("21:00"),
  ];

  @override
  void initState() {
    super.initState();
    _timeTabController =
        TabController(vsync: this, initialIndex: 0, length: timeTabs.length);
    _timeTabController.animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timeTabController.dispose();
    super.dispose();
  }

  ///时间选择
  Widget _timeSelection() {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        /// 固定整个布局的高，否则选中时间背景显示不全
        Container(
          height: 55,
        ),

        /// 未选中时间背景色
        Container(
          height: 55 - 5.0,
          color: Colors.black,
        ),

        /// 选中时间背景图片
        Positioned(
          width: width / 6,
          height: 55,
          left: _timeTabController.animation.value * width / 6,
          child: Image.asset(
            "images/time_selected_bg.png",
            fit: BoxFit.fill,
          ),
        ),
        TabBar(
          labelPadding: EdgeInsets.all(0),
          tabs: timeTabs,
          controller: _timeTabController,
          isScrollable: false,
          indicatorColor: Colors.transparent,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _timeSelection(),
        Expanded(
            child:
                TabBarView(controller: _timeTabController, children: <Widget>[
          Image.asset(
            "images/bg1.jpg",
            fit: BoxFit.fill,
          ),
          Image.asset(
            "images/bg2.jpg",
            fit: BoxFit.fill,
          ),
          Image.asset(
            "images/bg.jpg",
            fit: BoxFit.fill,
          ),
          Image.asset(
            "images/bg1.jpg",
            fit: BoxFit.fill,
          ),
          Image.asset(
            "images/bg2.jpg",
            fit: BoxFit.fill,
          ),
          Image.asset(
            "images/bg.jpg",
            fit: BoxFit.fill,
          )
        ]))
      ],
    );
  }
}
