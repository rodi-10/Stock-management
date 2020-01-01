import 'package:flutter/material.dart';

import 'package:icon_shadow/icon_shadow.dart';
import 'package:yourvone/src/blocs/auth_bloc.dart';
import 'package:yourvone/src/screens/dashboard_page.dart';

import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/screens/stocks_page.dart';
import 'package:yourvone/src/screens/home_page.dart';
import 'package:yourvone/src/utils/utils.dart';
import 'package:yourvone/src/widgets/home_drawer.dart';
import 'package:yourvone/src/screens/friends_page.dart';
import 'package:yourvone/src/screens/login_signup_page.dart';


class MainScreen extends StatefulWidget{
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var authBloc = AuthBloc();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3)).then((_){
      authBloc.fetchCurrentUser().then((user){
        if (user != null){
          Navigator.pushReplacementNamed(context, RoutesScreen.DASHBOARD, arguments: user);
        } else {
          Navigator.pushReplacementNamed(context, RoutesScreen.LOGIN);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'TRADER\nDRAFT',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40.0,
                    color: PrimaryColor,
                    fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(height: 50,),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
