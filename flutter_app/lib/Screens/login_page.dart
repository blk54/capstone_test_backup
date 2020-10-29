import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/profile_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/Screens/sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(500, 1334), allowFontScaling: true);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(50.0),
            right: ScreenUtil().setWidth(50.0)
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.amber[100], Colors.amber[400]],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to IDC You Pick!',
              style: TextStyle(color: Colors.red, fontSize: 27, fontWeight: FontWeight.bold),
            ),
            new Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0)),
            Text(
              'Please enter you phone number below:',
              style: TextStyle(color: Colors.red, fontSize: 17.5, fontWeight: FontWeight.bold),
            ),
            new Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0)),
            SizedBox(),
            _signInButton(),
          ],
        ),
      ),
    );
  }
  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.black,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ProfilePage();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google-logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}