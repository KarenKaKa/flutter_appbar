import 'package:flutter/material.dart';

///
/// @author songyaru
/// @date 2019/1/14
///
class MinePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("我的"),
    );
  }
}
