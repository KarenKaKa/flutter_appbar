# flutter_appbar

利用动画实现一个带背景图片的TabBar，TabBar选中状态有一个背景图片，TabBarView翻页的时候会跟随移动。
效果如下：

![image](https://github.com/KarenKaKa/flutter_appbar/blob/master/images/appbar.gif)
![image](https://github.com/KarenKaKa/flutter_appbar/blob/master/images/separator.gif)
![image](https://github.com/KarenKaKa/flutter_appbar/blob/master/images/nestedscrollview.gif)

### TabBar选中背景图片：
```java
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
        ///一行有6个Tab，每次移动的距离=当前移动到的位置*单个tab的宽
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

```

### TabBar用文字做分隔符
```java
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
          ? Text('/', style: TextStyle(color: Color(0xffd0d0d0), fontSize: 23))
          : Text(' ', style: TextStyle(color: Color(0xffd0d0d0), fontSize: 23))
    ],
  ));
}
```

### TabBar用自写任意控件做分隔符
```java
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
```

### TabBar用本地图片做分隔符
```java
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
              height: 15,
              child: Image.asset(
                'images/separator.png',
                fit: BoxFit.fitHeight,
                color: Colors.blueAccent,
              ),
            )
          : Container(
              width: 1,
            )
    ],
  ));
}
```

### NestedScrollView+TabBar+TabBarView实现顶部收缩
```java
@override
Widget build(BuildContext context) {
  double statusBarHeight = MediaQuery.of(context).padding.top;

  ///轮播图高度
  double _swiperHeight = 326 + 10.0;

  ///提示头部高度
  double _spikeHeight = 80;

  ///_appBarHeight算的是AppBar的bottom高度，kToolbarHeight是APPBar高，statusBarHeight是状态栏高度
  double _appBarHeight =
      _swiperHeight + _spikeHeight - kToolbarHeight - statusBarHeight;

  return NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          child: SliverAppBar(
            backgroundColor: Color(0xfff1f1f1),
            forceElevated: innerBoxIsScrolled,
            bottom: PreferredSize(
                child: Container(),
                preferredSize: Size.fromHeight(_appBarHeight)),

            ///TabBar顶部收缩的部分
            flexibleSpace: Column(
              children: <Widget>[
                _swiper(),
                _spike(),
              ],
            ),
          ),
        ),

        ///停留在顶部的TabBar
        SliverPersistentHeader(
          delegate: _SliverAppBarDelegate(_timeSelection()),
          pinned: true,
        ),
      ];
    },
    body: TabBarView(controller: _timeTabController, children: <Widget>[
      _listItem(),
      _listItem(),
      _listItem(),
      _listItem(),
      _listItem(),
      _listItem(),
    ]),
  );
}

```

