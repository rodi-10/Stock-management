import 'package:flutter/material.dart';
import 'package:yourvone/src/screens/add_friend_page.dart';
import 'package:yourvone/src/screens/dashboard_page.dart';
import 'package:yourvone/src/screens/friend_detail_page.dart';
import 'package:yourvone/src/screens/login_signup_page.dart';

import 'package:yourvone/src/screens/main_page.dart';
import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your V One',
      theme: ThemeData(
        primaryColor: PrimaryColor,
        brightness: Brightness.dark,
        // FIXME: additional themedata should be included
      ),
      onGenerateRoute: (RouteSettings settings) {
        final arg = settings.arguments;
        switch (settings.name) {
          case RoutesScreen.MAIN:
            return MaterialPageRoute(
                builder: (context) => MainScreen());
            break;
          case RoutesScreen.LOGIN:
            return MaterialPageRoute(
                builder: (context) => LoginPage());
            break;
          case RoutesScreen.DASHBOARD:
            return MaterialPageRoute(
                builder: (context) => DashboardPage(user: arg));
            break;
          case RoutesScreen.FRIEND_DETAIL:
            return MaterialPageRoute(
                builder: (context) => FriendDetailPage(user: arg));
            break;
          case RoutesScreen.ADD_FRIEND:
            return MaterialPageRoute(
                builder: (context) => AddFriendPage(args: arg));
            break;
          default:
            return MaterialPageRoute(
                builder: (context) => MainScreen());
            break;
        }
      }
    );
  }
}
