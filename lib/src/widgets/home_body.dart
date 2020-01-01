import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourvone/src/blocs/auth_bloc.dart';
import 'package:yourvone/src/blocs/portfolio_bloc.dart';
import 'package:yourvone/src/blocs/user_bloc.dart';
import 'package:yourvone/src/models/portfolio_model.dart';
import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';
//import 'package:auto_size_text/auto_size_text.dart';


class HomeBody extends StatefulWidget{
  final User user;
  HomeBody({Key key, @required this.user}) : super(key: key);
  @override
  State createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>{

  var portfolioBloc = PortfolioBloc();
  var userBloc = UserBloc();

  @override
  void initState() {
    userBloc.fetchUserData(widget.user.email);
    portfolioBloc.fetchPortfolio(widget.user.email);
    portfolioBloc.fetchUserStocks(widget.user.email);
    super.initState();
  }

  @override
  void dispose() {
    userBloc.dispose();
    portfolioBloc.dispose();
    super.dispose();
  }

  Widget getPortfolioListTile(Stock stock, bool isUp1, bool isUp2){

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: StreamBuilder<Stock>(
        stream: portfolioBloc.getStockData(stock.metaData.symbol),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    createListIcon(stock.metaData.symbol, Color(0xFF7D83F0)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        '${stock.metaData.name} (${stock.metaData.value})',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
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
                       //snapshot.data.timeSeriesDaily['2019-12-18'].low,
                        //snapshot.data.timeSeriesDaily[formatDateNow(DateTime.now())].low, ///TODO: specify date.
                        //Work Around
                        snapshot.data.timeSeriesDaily.values.elementAt(0).low,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: isUp1 ? greenUpPositive : redDownNegative,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          //Work Around
                          snapshot.data.timeSeriesDaily.values.elementAt(0).high,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: isUp2 ? greenUpPositive : redDownNegative,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
          else if (snapshot.hasError) {
            return Text("An error occurred");
          }
          else{
            return Text('No Available data for stock: ${stock.metaData.symbol}');
          }
          //return CircularProgressIndicator();
        })
    );
  }

  Widget myStocksWidget () {
    return StreamBuilder<List<Stock>>(
        // TODO: this should be changed now. getting a portfolio should ONLY return stock IDs.
        // TODO: this works before because portfolioBloc.portfolio returns actual stock data - which is wrong. @darren
        stream: portfolioBloc.stocks,
        builder: (context, snapshot){
          if (snapshot.hasData){
//            List<Widget> widgets = [];
//            for(int x=0; x<snapshot.data.stocks.length;x++){
//              widgets.add(
//                getPortfolioListTile(snapshot.data.stocks[x], true, false)
//              );
//            }
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return getPortfolioListTile(snapshot.data[index], true, false);
              }
            );
//            return Column(
//              children: widgets,
//            );
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          return Padding(padding: EdgeInsets.all(5.0),child: Text('You have no current Stocks available'));
        }
    );
  }

  Widget getUserWidget(){
    return StreamBuilder(
      stream: userBloc.user,
      builder: (context, AsyncSnapshot<User> snapshot){
        if (snapshot.hasData){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'YOUR NET WORTH',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.0,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ),
                Text(
                  'USD ${snapshot.data.netWorth?? "0"}',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w200,
                    color: PrimaryColor
                  ),
                )
              ],
            ),
          );
        }else if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        return Container(
          width: 100.0,
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView( // NOTE: this should be listview, so that portfolio list would work
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              width: getWidthByScreen(context, ratio: 0.85),
              //height: getHeightByScreen(context, ratio: 0.24),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: headerBackgroundColor,
                child: getUserWidget(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              width: getWidthByScreen(context, ratio: 0.80),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: headerBackgroundColor,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                      child: Text(
                        'YOUR STOCKS', // FIXME: not sure about this label, should be changed
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70
                        ),
                      ),
                    ),
                    getHeaderDivider(),
                    myStocksWidget()
                  ],
                ),
              ),

            ),
          )
        ],
      ),
    );
  }
}
