import 'package:flutter/material.dart';

import 'package:yourvone/src/utils/utils.dart';
import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/screens/search_detail_page.dart';


class SearchResultList extends StatefulWidget{
  @override
  _SearchResultListState createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {

  Widget getSearchResultTile(String iconTitle, Color iconColor, String title, String category1, String category2){
    bool _isSelected = false;
    return GestureDetector(
      onTap: (){
        print('tapped here');
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchDetailPage())
        );
      },
      child: Container(
        color: PrimaryColor,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  createListIcon(iconTitle, iconColor),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            title,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  category1,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12.0
                                  ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Icon(
                                  Icons.fiber_manual_record,
                                  size: 5.0,
                                  color: Colors.white70
                                ),
                              ),
                              Text(
                                category2,
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12.0
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              GestureDetector(
                child: _isSelected
                        ? Icon(Icons.check_circle)
                        : Icon(Icons.add_circle_outline),
                onTap: (){
                  // FIXME: having problem with changing value of bool _isSelected, wont change with setState(), maybe because it's not an attribute of the State _SearchResultListState
                  print('tapped here');
                  setState(() {
                    _isSelected
                        ? _isSelected = false
                        : _isSelected = true;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: ListView(
        children: <Widget>[
          // FIXME: should be dynamic
          getSearchResultTile('DIG', Color(0xFFDC94F7), 'Bitcoin', 'CRYPTO', 'BTC/USD'),
          getSearchResultTile('DIG', Color(0xFF1E8BED), 'Bitcoin 0.1', 'CRYPTO', 'BITCOIN 0.1'),
          getSearchResultTile('DIG', Color(0xFF1E8BED), 'Ripple', 'CRYPTO', 'XRP/USD'),
          getSearchResultTile('DIG', Color(0xFFDC94F7), 'Etherium 0.1', 'CRYPTO', 'ETH/USD 0.1'),
          getSearchResultTile('DIG', Color(0xFF1E8BED), 'Monero', 'CRYPTO', 'XMR/USD'),
          getSearchResultTile('DIG', Color(0xFF1E8BED), 'Ethereum', 'CRYPTO', 'XMR/USD'),
          getSearchResultTile('DIG', Color(0xFFDC94F7), 'Monero 0.1', 'CRYPTO', 'XMR/USD 0.1'),
          getSearchResultTile('DIG', Color(0xFFDC94F7), 'Bitcoin', 'CRYPTO', 'BTC/USD'),
          getSearchResultTile('DIG', Color(0xFF1E8BED), 'Bitcoin 0.1', 'CRYPTO', 'BITCOIN 0.1'),
          getSearchResultTile('DIG', Color(0xFF1E8BED), 'Ripple', 'CRYPTO', 'XRP/USD'),
          getSearchResultTile('DIG', Color(0xFFDC94F7), 'Etherium 0.1', 'CRYPTO', 'ETH/USD 0.1'),
          getSearchResultTile('DIG', Color(0xFF1E8BED), 'Monero', 'CRYPTO', 'XMR/USD'),
          getSearchResultTile('DIG', Color(0xFF1E8BED), 'Ethereum', 'CRYPTO', 'XMR/USD'),
          getSearchResultTile('DIG', Color(0xFFDC94F7), 'Monero 0.1', 'CRYPTO', 'XMR/USD 0.1'),

        ],
      ),
    );
  }
}
