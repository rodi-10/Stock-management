import 'package:flutter/material.dart';

class HomeTabItem extends StatelessWidget{

  final VoidCallback onTap;
  final int index;
  final String title;
  final int currentTab;

  HomeTabItem({this.onTap, this.index, this.title, this.currentTab});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Text(title, style: TextStyle(fontSize: 15.0, color: currentTab == index ? Colors.black : Colors.black38, fontWeight: currentTab == index ? FontWeight.w500 : FontWeight.w400)),
      ),
    );
  }
}
