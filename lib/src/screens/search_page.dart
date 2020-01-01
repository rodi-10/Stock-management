import 'package:flutter/material.dart';

import 'package:yourvone/src/widgets/search_header.dart';
import 'package:yourvone/src/widgets/search_result_list.dart';


class SearchPage extends StatefulWidget{
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Column(
        children: <Widget>[
          SearchHeader(),
          SearchResultList()
        ],
      ),
    );
  }
}
