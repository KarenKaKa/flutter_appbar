# flutter_appbar

利用动画实现一个带背景图片的TabBar，TabBar选中状态有一个背景图片，TabBarView翻页的时候会跟随移动。
效果如下：

![image](https://github.com/KarenKaKa/flutter_appbar/blob/master/images/appbar.gif)
![image](https://github.com/KarenKaKa/flutter_appbar/blob/master/images/separator.gif)

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

