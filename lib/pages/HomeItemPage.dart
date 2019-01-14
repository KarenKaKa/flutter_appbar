import 'package:flutter/material.dart';
import 'package:flutter_appbar/model/GoodsItemModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeItemPage extends StatefulWidget {
  @override
  _HomeItemPageState createState() => _HomeItemPageState();
}

Widget _timeTabBarItem(String title) {
  return Tab(
      child: Text(
    title,
    style: TextStyle(color: Colors.white, fontSize: 18),
  ));
}

class _HomeItemPageState extends State<HomeItemPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HomeItemPage> {
  TabController _timeTabController;
  List<GoodsItemModel> topList = List();
  List<Tab> timeTabs = <Tab>[
    _timeTabBarItem("10:00"),
    _timeTabBarItem("13:00"),
    _timeTabBarItem("15:00"),
    _timeTabBarItem("17:00"),
    _timeTabBarItem("19:00"),
    _timeTabBarItem("21:00"),
  ];

  Widget _swiperBuilder(BuildContext context, int index) {
    return Image.asset(
      topList[index].img,
      fit: BoxFit.fill,
    );
  }

  ///顶部banner
  Widget _swiper() {
    return Container(
        height: 326 + 10.0,
        padding: EdgeInsets.only(bottom: 10),
        child: Swiper(
          itemBuilder: _swiperBuilder,
          itemWidth: 326,
          itemCount: topList.length,
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  color: Color(0x80000000),
                  activeColor: Color(0xff000000),
                  size: 10,
                  activeSize: 10,
                  space: 5),
              margin: EdgeInsets.only(bottom: 17)),
          autoplay: true,
          duration: 150,
          controller: SwiperController(),
          scrollDirection: Axis.horizontal,
          onTap: (index) {},
        ));
  }

  ///今日秒杀
  Widget _spike() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "这是选择时间的提示头部",
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "SALE",
            style: TextStyle(
                letterSpacing: 10, fontSize: 12, color: Color(0xff7d7d7d)),
          )
        ],
      ),
    );
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

  @override
  void initState() {
    super.initState();
    _timeTabController =
        TabController(vsync: this, initialIndex: 0, length: timeTabs.length);
    _timeTabController.animation.addListener(() {
      setState(() {});
    });
    topList.add(GoodsItemModel(name: "name1", img: "images/bg1.jpg"));
    topList.add(GoodsItemModel(name: "name2", img: "images/bg2.jpg"));
    topList.add(GoodsItemModel(name: "name3", img: "images/bg.jpg"));
  }

  @override
  void dispose() {
    _timeTabController.dispose();
    super.dispose();
  }

  Widget _listItem() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        itemCount: 5,
        itemBuilder: (context, i) => Image.asset("images/bg1.jpg"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double _swiperHeight = 326 + 10.0;
    double _spikeHeight = 80;
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
              flexibleSpace: Column(
                children: <Widget>[
                  _swiper(),
                  _spike(),
                ],
              ),
            ),
          ),
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

  @override
  bool get wantKeepAlive => true;
}

///TabBar的代理
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final Stack _tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  double get maxExtent => 55;

  @override
  double get minExtent => 55;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
