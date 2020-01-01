import 'package:flutter/material.dart';

import 'package:yourvone/src/utils/utils.dart';
import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/widgets/search_detail_body.dart';
import 'package:yourvone/src/widgets/search_detail_header.dart';



class SearchDetailPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SearchDetailHeader(),
              SearchDetailBody()
            ],
          ),
        )
    );
  }
}