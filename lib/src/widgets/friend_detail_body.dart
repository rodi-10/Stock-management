import 'package:flutter/material.dart';
import 'package:yourvone/src/models/user_model.dart';

import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';
import 'package:yourvone/src/models/portfolio_model.dart';
import 'package:yourvone/src/blocs/portfolio_bloc.dart';


class FriendDetailBody extends StatefulWidget{
  final User user;
  FriendDetailBody({Key key, @required this.user}) : super(key: key);

  @override
  State createState() => _FriendDetailBodyState();
}

class _FriendDetailBodyState extends State<FriendDetailBody> {

  var portfolioBloc = PortfolioBloc();

  Widget getUserWidget(String displayName, double balance){ // NOTE: taken from Stock List
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: headerBackgroundColor,
            borderRadius: BorderRadius.circular(15.0)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.person_pin,
                size: 80.0,
                color: PrimaryColor,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${widget.user.displayName}',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'NET WORTH',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.0,
                            fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                    Text(
                      'USD ${balance}',
                      style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w200,
                          color: PrimaryColor
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getPortfolioListTile(Stock stock, bool isUp1, bool isUp2){ // TODO: if Darren approves of this widget being written this way, maybe this can be recycled to the utils module
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              createListIcon(stock.metaData.symbol, Color(0xFF7D83F0)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  stock.metaData.name,
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  stock.timeSeriesDaily[formatDateNow(DateTime.now())].low,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: isUp1 ? greenUpPositive : redDownNegative,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    stock.timeSeriesDaily[formatDateNow(DateTime.now())].high,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: isUp2 ? greenUpPositive : redDownNegative,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getPortfolioWidget(){ // NOTE: taken from home_body.dart
    return StreamBuilder(
      stream: portfolioBloc.portfolio,
        builder: (context, AsyncSnapshot<Portfolio> snapshot){
          if (snapshot.hasData){
            List<Widget> widgets = [];
            for(int x=0; x<snapshot.data.stocks.length;x++){
              print(snapshot.data.stocks[x].metaData.name);
              widgets.add(
                  getPortfolioListTile(snapshot.data.stocks[x], true, false)
              );
            }
            return Column( // TODO: should be populated with the data from portfolio. used just for checking of page is scrollable.
              children: widgets,
            );
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          return Container(
            width: 100.0,
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  Widget getPortfolioCard(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
      child: Card(
        color: headerBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: getPortfolioWidget(),
        )
      ),
    );
  }

  @override
  void initState() {
    portfolioBloc.fetchPortfolio(widget.user.email);
    super.initState();
  }

  @override
  void dispose() {
    portfolioBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          getUserWidget(widget.user.displayName, 13434.13),
          Center(
            child: Text(
              'THIS USER\'S PORTFOLIO', // FIXME: not sure about 'portfolio' wording, this should be changed
              style: TextStyle(
                color: Colors.white70,
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          getPortfolioCard()
        ],
      ),
    );
  }
}
