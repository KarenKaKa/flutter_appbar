import 'package:flutter/material.dart';

///
/// @author songyaru
/// @date 2019/1/14
///
class CartPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("购物车"),
    );
  }
}
