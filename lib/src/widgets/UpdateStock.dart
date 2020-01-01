import 'package:flutter/material.dart';
import 'package:yourvone/src/blocs/auth_bloc.dart';
import 'package:yourvone/src/blocs/portfolio_bloc.dart';
import 'package:yourvone/src/models/portfolio_model.dart';
import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/resources/portfolio_provider.dart';
import 'package:yourvone/src/resources/portfolio_repository.dart';
import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';

class UpdateStock extends StatefulWidget {
  final String symbol;
  final String name;
  final double finalPrice;
  final bool forBuy;

  UpdateStock(
      {Key key,
      @required this.symbol,
      @required this.name,
      @required this.finalPrice,
      @required this.forBuy})
      : super(key: key);
  @override
  _UpdateStockState createState() => _UpdateStockState();
}

class _UpdateStockState extends State<UpdateStock> {
  TextEditingController _total = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getStock();
    super.initState();
  }

  getStock() async {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
                '${!widget.forBuy ? 'How many you want to SELL' : 'How many you want to BUY'}'),
            TextFormField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              controller: _total,
            )
          ],
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          color: PrimaryColor,
          child: Text('Confirm'),
          onPressed: () async {
            User user = await AuthBloc().fetchCurrentUser();
            if (_total.text.length > 0) {
              bool isSuccessTransaction = false;
              if (widget.forBuy) {
                isSuccessTransaction = await PortfolioRepository().buyStocks(
                    user.email,
                    widget.symbol,
                    widget.name,
                    int.tryParse(_total.text),
                    widget.finalPrice);
              } else {
                isSuccessTransaction = await PortfolioRepository().sellStocks(
                    user.email,
                    widget.symbol,
                    widget.name,
                    int.tryParse(_total.text),
                    widget.finalPrice);
              }
              if (isSuccessTransaction == true) {
                Navigator.pushReplacementNamed(context, RoutesScreen.MAIN);
              } else {
                showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text('Transaction Failed'),
                      content: Text('Please verify your stock details'),
                    ));
              }
            } else {
              showDialog(
                  context: context,
                  child: AlertDialog(
                    content: Text('Please enter a valid amount'),
                  ));
            }
          },
        ),
        RaisedButton(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(side: BorderSide(color: PrimaryColor)),
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
