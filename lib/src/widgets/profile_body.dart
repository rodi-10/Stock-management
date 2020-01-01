import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourvone/src/blocs/auth_bloc.dart';
import 'package:yourvone/src/blocs/user_bloc.dart';
import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';

class ProfileBody extends StatefulWidget {
  final User user;
  ProfileBody({Key key, @required this.user}) : super(key: key);
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  var userBloc = UserBloc();
  var _auth = AuthBloc();

  bool isForUpdate = false;
  String dateToday = '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';
  String _birthday;
  String _gender;
  TextEditingController _displayName = TextEditingController();
  TextEditingController _location = TextEditingController();

  @override
  void initState() {
    userBloc.fetchUserData(widget.user.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userBloc.user,
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
              child: SizedBox(
                width: getWidthByScreen(context, ratio: 0.85),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: headerBackgroundColor,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Icon(
                          Icons.person_pin,
                          size: 80.0,
                          color: PrimaryColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Display Name'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          enabled: isForUpdate,
                          decoration: InputDecoration(hintStyle: TextStyle(color: Colors.white),hintText: !isForUpdate ? snapshot.data.displayName : ''),
                          controller: _displayName,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Gender'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: !isForUpdate ? Text('${snapshot.data.gender ?? 'No registered Gender'}')
                            : Row(children: <Widget>[Flexible(
                          child: RadioListTile(
                            title: Text('Male'),
                            value: 'Male',
                            groupValue: _gender,
                            onChanged: (val) {
                              setState(() {
                                _gender = val;
                                print(_gender);
                              });
                            },
                          ),
                        ),
                          Flexible(
                            child: RadioListTile(
                              title: Text('Female'),
                              value: 'Female',
                              groupValue: _gender,
                              onChanged: (val) {
                                setState(() {
                                  _gender = val;
                                  print(_gender);
                                });
                              },
                            ),
                          ),],)
                      ),
                      Divider(thickness: 2,indent: 8,endIndent: 8,),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Birthday'),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: !isForUpdate
                              ? Text('${snapshot.data.birthday ?? 'No registered Birthday'}')
                              : RaisedButton(
                                  color: PrimaryColor,
                                  child: Container(width: 110, child:Center(child: Row(children: <Widget>[Icon(Icons.date_range), Text(' ${_birthday ?? dateToday}')],),)),
                                  onPressed: () async {
                                    final pickedDate = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1700),
                                        initialDate: DateTime.now(),
                                        lastDate: DateTime.now());
                                    setState(() {
                                      if (pickedDate != null) {
                                        _birthday =
                                            '${pickedDate.month.toString()}/${pickedDate.day.toString()}/${pickedDate.year.toString()}';
                                      }
                                    });
                                  },
                                )),
                      Divider(thickness: 2,indent: 8,endIndent: 8,),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Location'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          enabled: isForUpdate,
                          decoration: InputDecoration(hintStyle: TextStyle(color: Colors.white), hintText: !isForUpdate ? snapshot.data.location ?? 'No registered Location' : ''),
                          controller: _location,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: 250,
                          child: RaisedButton(
                            color: PrimaryColor,
                            child: !isForUpdate ? Text('Update') : Text('Save'),
                            onPressed: () async {
                              if (!isForUpdate) {
                                setState(() {
                                  isForUpdate = true;
                                  _displayName.text = snapshot.data.displayName ?? '';
                                  _gender = snapshot.data.gender ?? null;
                                  _birthday = snapshot.data.birthday ?? null;
                                  _location.text = snapshot.data.location;
                                });
                              } else {
                                User userUpdateModel = User(
                                  displayName: _displayName.text.length > 0 ? _displayName.text : snapshot.data.displayName,
                                  gender: _gender ?? snapshot.data.gender,
                                  birthday: _birthday ?? snapshot.data.birthday,
                                  location:  _location.text.length > 0 ? _location.text : snapshot.data.location
                                );
                                 bool isSuccess = await _auth.updateUser(userUpdateModel);

                                 if(isSuccess) {
                                   showDialog(barrierDismissible: false,context: context,child: AlertDialog(content: Text('Update Successful! Please relogin'),actions: <Widget>[
                                     RaisedButton(child: Text('Confirm'),onPressed: (){
                                       _auth.signOutUser().then((_) {
                                         Navigator.pushReplacementNamed(
                                             context, RoutesScreen.MAIN);
                                       });
                                     },)
                                   ],));
                                 }
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: SizedBox(
                          width: 200,
                          child: RaisedButton(
                            color: PrimaryColor,
                            child: Text('Sign Out'),
                            onPressed: () {
                              _auth.signOutUser().then((_) {
                                Navigator.pushReplacementNamed(
                                    context, RoutesScreen.MAIN);
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Text('No data');
          }
        });
  }
}
