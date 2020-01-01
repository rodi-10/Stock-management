import 'package:flutter/material.dart';

import 'package:yourvone/src/utils/color_helper.dart';


class HomeDrawer extends StatelessWidget{

  Widget getHeaderListTile(String title, IconData icon, VoidCallback callback){
    return ListTile(
      title: Text(title),
      trailing: Icon(icon),
      onTap: callback,
    );
  }

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Welcome, John.', // FIXME: should be static
                style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
//            decoration: BoxDecoration(
//                image: DecorationImage(
//                    image: ExactAssetImage('assets/home_drawer_header5.jpg'),
//                    fit: BoxFit.cover
//                )
//            ),
          ),
          getHeaderListTile('Settings', Icons.settings, (){}),
          Divider(),
          getHeaderListTile('Logout', Icons.exit_to_app, (){}),
          Divider(),
        ],
      ),
    );
  }
}