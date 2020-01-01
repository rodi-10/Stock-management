import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:yourvone/src/blocs/portfolio_bloc.dart';
import 'package:yourvone/src/blocs/user_bloc.dart';
import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/screens/friends_page.dart';
import 'package:yourvone/src/screens/home_page.dart';
import 'package:yourvone/src/screens/profile_page.dart';
import 'package:yourvone/src/screens/stocks_page.dart';
import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/widgets/home_drawer.dart';

class DashboardPage extends StatefulWidget {
  final User user;
  DashboardPage({Key key, @required this.user}) : super(key: key);
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  var userBloc = UserBloc();
  var portfolioBloc = PortfolioBloc();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    userBloc.fetchUserData(widget.user.email);
    super.initState();
  }

  @override
  void dispose() {
    userBloc.dispose();
    portfolioBloc.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 75.0, // FIXME: should use MediaQuery
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white30,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 35.0,
          backgroundColor: PrimaryColor,
          elevation: 10.0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedIndex == 0 // FIXME: should be recycled(?), maybe put to a utils class
                  ? IconShadowWidget(
                Icon(Icons.home, color: Colors.white, size: 35.0,),
                shadowColor: Colors.white70,
              )
                  : Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? IconShadowWidget(
                Icon(Icons.people_outline, color: Colors.white, size: 35.0,),
                shadowColor: Colors.white70,
              )
                  : Icon(Icons.people_outline),
              title: Text('Friends'),
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? IconShadowWidget(
                Icon(Icons.equalizer, color: Colors.white, size: 35.0,),
                shadowColor: Colors.white70,
              )
                  : Icon(Icons.equalizer),
              title: Text('Stats'),
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? IconShadowWidget(
                Icon(Icons.person_outline, color: Colors.white, size: 35.0,),
                shadowColor: Colors.white70,
              )
                  : Icon(Icons.person_outline),
              title: Text('Profile'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      body: IndexedStack(
      index: _selectedIndex,
      children: <Widget>[
        HomePage(user: widget.user),
        FriendsPage(user: widget.user),
        StocksPage(portfolioBloc: portfolioBloc),
        MyProfile(user: widget.user)
      ],
    ),
      drawer: HomeDrawer(),
    );
  }
}
