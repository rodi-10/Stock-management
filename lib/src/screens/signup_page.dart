import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:yourvone/src/models/user_model.dart';

import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';
import 'package:yourvone/src/blocs/auth_bloc.dart';

class SignUpPage extends StatefulWidget {
  @override
  State createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var authBloc = AuthBloc();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  String _gender;
  String _birthday;
  String dateToday = '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';
  bool _userAgrees = false;

  Widget getHeader(BuildContext context) {
    return Container(
        width: double.infinity,
        height: getHeightByScreen(context, ratio: 0.10),
        color: headerBackgroundColor,
        child: Center(
          child: Text(
            'Signup to Trader Draft',
            style: TextStyle(
                color: PrimaryColor,
                fontSize: 24.0,
                fontWeight: FontWeight.w400),
          ),
        ));
  }

  Widget getWelcomeCard(BuildContext context) {
    return Container(
      height: getHeightByScreen(context, ratio: 0.20),
      margin: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: headerBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                width: getWidthByScreen(context, ratio: 0.20),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconShadowWidget(
                          Icon(
                            Icons.equalizer,
                            color: PrimaryColor,
                            size: 30.0,
                          ),
                          shadowColor: Colors.lightBlue,
                        ),
                        IconShadowWidget(
                          Icon(
                            Icons.people,
                            color: PrimaryColor,
                            size: 30.0,
                          ),
                          shadowColor: Colors.lightBlue,
                        ),
                        IconShadowWidget(
                          Icon(
                            Icons.attach_money,
                            color: PrimaryColor,
                            size: 30.0,
                          ),
                          shadowColor: Colors.lightBlue,
                        )
                      ],
                    )),
              ),
              Expanded(
                child: Text(
                  'Welcome to Trader Draft — Fantasy stock picking app all in one. \n\n\nGet started by creating an account.',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getFormCard(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: headerBackgroundColor,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Fill in your information below',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextFormField(
                  controller: _displayNameController,
                  maxLines: 1,
                  autofocus: false,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: PrimaryColor),
                      ),
                      focusColor: Colors.white70,
                      hintText: 'Display Name(Required)',
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.grey,
                      )),
                  validator: (value) =>
                      value.isEmpty ? 'Password can\'t be empty' : null,
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.group, color: Colors.grey),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Gender:',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Flexible(
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
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.date_range, color: Colors.grey),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Birtday: ',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    RaisedButton(
                      color: PrimaryColor,
                      child: Row(children: <Widget>[Icon(Icons.calendar_today),Text(
                          ' ${_birthday ?? ''}'),],),
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
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextFormField(
                  maxLines: 1,
                  controller: _locationController,
                  autofocus: false,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: PrimaryColor),
                      ),
                      focusColor: Colors.white70,
                      hintText: 'Location',
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      )),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextFormField(
                  controller: _emailController,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: PrimaryColor),
                      ),
                      focusColor: Colors.white70,
                      hintText: 'Email(Required)',
                      icon: Icon(
                        Icons.mail,
                        color: Colors.grey,
                      )),
                  validator: (value) =>
                      value.isEmpty ? 'Email can\'t be empty' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextFormField(
                  controller: _passwordController,
                  maxLines: 1,
                  obscureText: true,
                  autofocus: false,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: PrimaryColor),
                      ),
                      focusColor: Colors.white70,
                      hintText: 'Password (Required, case sensitive)',
                      icon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      )),
                  validator: (value) =>
                      value.isEmpty ? 'Password can\'t be empty' : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPrivacyPolicyAgreementText(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            width: getWidthByScreen(context, ratio: 0.7),
            child: Text(
              'By signing up, you agree to our Terms of Service and Conditions, which are in',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          InkWell(
            child: Text(
              'this link',
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
            ),
            onTap: () {
              // TODO: add a link to the terms and conditions?
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                checkColor: Colors.white70,
                activeColor: PrimaryColor,
                value: _userAgrees,
                onChanged: (bool value) {
                  setState(() {
                    _userAgrees = value;
                  });
                },
              ),
              Text(
                'I agree to your Terms of Service and Conditions',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget getSignUpButton(BuildContext context) {
    return Container(
      width: getWidthByScreen(context, ratio: 0.80),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20.0),
        ),
        onPressed: () {
          if (_displayNameController.text.length < 1 ||
              _emailController.text.length < 1 ||
              _passwordController.text.length < 1)
            showDialog(
                context: context,
                child: AlertDialog(
                  title: Text('Invalid Inputs'),
                  content: Text('Please verify Required Fields'),
                ));
          else if (_userAgrees) {
            User registerUser = User(
              displayName: _displayNameController.text,
              gender: _gender ?? null,
              birthday: _birthday ?? null,
              location: _locationController.text.length > 0 ? _locationController.text : null,
              email: _emailController.text,
            );
            authBloc
                .signUp(registerUser, _passwordController.text)
                .then((user) {
              if (user != null) {
                registerUser = null;
                //Firebase automatically sign in registered user, preventing with signOut Functionality
                authBloc.signOutUser();
                Navigator.pop(context);
              }
            });
          } else
            showDialog(
                context: context,
                child: AlertDialog(
                  title: Text('Failed!'),
                  content:
                      Text('Please Review and agree to Terms and Conditions!'),
                ));

        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            getHeader(context),
            getWelcomeCard(context),
            getFormCard(context),
            getPrivacyPolicyAgreementText(context),
            getSignUpButton(context),
          ],
        ),
      ),
    );
  }
}
