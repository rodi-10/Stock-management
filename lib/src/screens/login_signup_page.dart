import 'package:flutter/material.dart';
import 'package:yourvone/src/blocs/auth_bloc.dart';
import 'package:yourvone/src/blocs/user_bloc.dart';
import 'package:yourvone/src/screens/signup_page.dart';
import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import 'package:yourvone/src/widgets/home_header.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSigningIn = false;
  var authBloc = AuthBloc();
  var userBloc = UserBloc();

  @override
  void initState() {
    authBloc.fetchCurrentUser();
    // TODO: add further steps after fetching user that's already signed in
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
    userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: <Widget>[HomeHeader(), _loginCard()],
        ),
      ),
    );
  }

  Widget _loginCard() {
    var squareEdgeLength = getHeightByScreen(context, ratio: 0.40);

    return Container(
      margin: EdgeInsets.only(top: squareEdgeLength / 5),
//      height: squareEdgeLength, // FIXME: i removed height for now
      width: squareEdgeLength,
      child: Card(
        color: headerBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'LOGIN',
                style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: TextFormField(
                controller: _emailController,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: InputDecoration(
                    hintText: 'Email',
                    icon: Icon(
                      Icons.mail,
                      color: PrimaryColor,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: TextFormField(
                controller: _passwordController,
                maxLines: 1,
                obscureText: true,
                autofocus: false,
                decoration: InputDecoration(
                    hintText: 'Password',
                    icon: Icon(
                      Icons.lock,
                      color: PrimaryColor,
                    )),
                validator: (value) => value.isEmpty
                    ? 'Password can\'t be empty.'
                    : null, // TODO: add more validators here
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: RaisedButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0),
                  ),
                  onPressed: !_isSigningIn ? () {
                    setState(() {
                      _isSigningIn = true;
                      FocusScope.of(context).unfocus();
                    });
                    authBloc.signIn(_emailController.text, _passwordController.text, context).then((user) {
                      print(user);
                      setState(() {
                        _isSigningIn = false;
                      });
                      // NOTE: step 2: open new widget and push to new window
                      if (user != null){
                        Navigator.pushReplacementNamed(context, RoutesScreen.DASHBOARD, arguments: user);
                      }
                    });
                  } : null,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(height: 1, width: 80, color: Colors.white30,),
                  Text("or",style: TextStyle(color: Colors.white30),),
                  Container(height: 1, width: 80, color: Colors.white30,),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: GoogleSignInButton(
                onPressed: !_isSigningIn ? () {
                  setState(() {
                    _isSigningIn = true;
                  });
                  authBloc.googleSignInSignUp(context).then((user) {
                    setState(() {
                      _isSigningIn = false;
                    });
                    print(user);
                    if (user != null){
                      Navigator.pushReplacementNamed(context, RoutesScreen.DASHBOARD, arguments: user);
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return getAlertDialog('Error', 'Login failed. Please sign up or try again.', context);
                          });
                    }
                  });
                } : null,
                darkMode: false,
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: FacebookSignInButton(
                onPressed: !_isSigningIn ? () {
                  setState(() {
                    _isSigningIn = true;
                  });
                  authBloc.facebookSignInSignUp(context).then((user) {
                    setState(() {
                      _isSigningIn = false;
                    });
                    if (user != null){
                      print(user);
                      Navigator.pushReplacementNamed(context, RoutesScreen.DASHBOARD, arguments: user);
                    }
                  });
                } : null,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(10.0),
              child: InkWell(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: !_isSigningIn ? PrimaryColor : Colors.white30,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline),
                ),
                onTap: !_isSigningIn ? () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpPage()));
                } : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
