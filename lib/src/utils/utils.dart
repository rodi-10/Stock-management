import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'color_helper.dart';

class RoutesScreen{
  static const String LOGIN = "Login";
  static const String DASHBOARD = "Dashboard";
  static const String MAIN = "Main";
  static const String FRIEND_DETAIL = "FriendDetail";
  static const String ADD_FRIEND = "AddFriend";
}

class AlphaVantageFunctions{
  static const String getStock = "TIME_SERIES_DAILY";
  static const String symbolSearch = "SYMBOL_SEARCH";
}

const String AlphaVantageAPIKey = 'CROOLZH4H9FJ2ODQ';
const String AlphaVantageHost = 'https://www.alphavantage.co/query';

Size screenSize(BuildContext context){
  return MediaQuery.of(context).size;
}

double getHeightByScreen(BuildContext context, {double ratio}){
  return screenSize(context).height * ratio;
}

double getWidthByScreen(BuildContext context, {double ratio}){
  return screenSize(context).width * ratio;
}

Widget getHeaderDivider(){
  return Divider(
    color: Colors.blue[900],
    thickness: 0.25,
  );
}

Widget createListIcon(String text, Color color){
  return Container(
    width: 45.0,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0)
    ),
    child: Padding(
      padding: EdgeInsets.all(7.5),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white70),
        ),
      ),
    ),
  );
}

Widget getAlertDialog(String title, String text, BuildContext context) {
  return AlertDialog(
    title: Text(title),
    backgroundColor: headerBackgroundColor,
    content: Text(
      text,
      style: TextStyle(
          color: PrimaryColor, fontSize: 22.0, fontWeight: FontWeight.w300),
    ),
    actions: <Widget>[
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("DISMISS"))
    ],
  );
}

String formatDateNow(DateTime dt){
  return DateFormat('yyyy-MM-dd').format(dt);
}