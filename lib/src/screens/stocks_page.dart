import 'package:flutter/material.dart';
import 'package:yourvone/src/blocs/portfolio_bloc.dart';

import 'package:yourvone/src/widgets/stocks_page_header.dart';
import 'package:yourvone/src/widgets/stocks_page_list.dart';


class StocksPage extends StatelessWidget{
  final PortfolioBloc portfolioBloc;
  StocksPage({Key key, @required this.portfolioBloc}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Column(
        children: <Widget>[
          StocksPageHeader(portfolioBloc: portfolioBloc),
          StocksPageList(portfolioBloc: portfolioBloc)
        ],
      ),
    );
  }
}
