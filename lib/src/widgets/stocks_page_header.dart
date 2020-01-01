import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourvone/src/blocs/portfolio_bloc.dart';
import 'package:yourvone/src/utils/color_helper.dart';

class StocksPageHeader extends StatefulWidget{
  final PortfolioBloc portfolioBloc;
  StocksPageHeader({Key key, @required this.portfolioBloc}) : super(key: key);
  @override
  State createState() => _StocksPageHeaderState();
}


class _StocksPageHeaderState extends State<StocksPageHeader>{
  FocusNode focusNode;
  Timer _debounce;
  TextEditingController _searchFieldController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _searchFieldController.addListener(_onSearchChanged);
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    _searchFieldController.removeListener(_onSearchChanged);
    _searchFieldController.dispose();
    widget.portfolioBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: headerBackgroundColor,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
              child: StreamBuilder<bool>(
                stream: widget.portfolioBloc.isSearchField,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(icon: Icon(snapshot.data ? Icons.close : Icons.search, color: PrimaryColor, size: 30.0,), onPressed: (){
                          widget.portfolioBloc.toggleSearchField(snapshot.data);
                          if(snapshot.data){
                            Future.delayed(Duration(milliseconds: 100)).then((_){
                              FocusScope.of(context).requestFocus(focusNode);
                            });
                          } else {
                            _searchFieldController.clear();
                            widget.portfolioBloc.fetchSearchResult("");
                          }
                        }),
//                Icon(Icons.account_box, color: PrimaryColor, size: 35.0,),
                        snapshot.data
                            ? Container(
                          width: 250,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.all(Radius.circular(30))),
                          child: TextField(
                            controller: _searchFieldController,
                            focusNode: focusNode,
                            maxLines: 1,
                            decoration: new InputDecoration.collapsed(
                              hintText: 'Search stocks...',
                            ),
                          ),
                        )
                            : Column(
                          children: <Widget>[
                            Text(
                              "Stocks",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 27.0,
                                  color: PrimaryColor
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 7.5),
                              child:
                              Container(
                                decoration: BoxDecoration(
                                    color: headerArrowColor,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                ),
                                height: 4.0,
                                width: 100.0,
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: snapshot.data ? 0 : 35),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }
              ),
            ),
          ),

        ],
      )
    );
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      print(_searchFieldController.text);
      widget.portfolioBloc.fetchSearchResult(_searchFieldController.text);
      // do something with _searchQuery.text
    });
  }
//  Widget _buildSearchBar(){
//    return Container(
//      child: ,
//    )
//  }
}
