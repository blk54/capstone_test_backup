import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/profile_page.dart';
import 'package:flutter_app/Screens/home_page.dart';
import 'package:flutter_app/Screens/sign_in.dart';
import 'login_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
        actions: <Widget>[],
        backgroundColor: Colors.redAccent,
        elevation: 50.0,
        brightness: Brightness.dark,
      ),
      drawer: Drawer(
        child: new Container(
          decoration: BoxDecoration(
              color: Colors.amber[300]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    new UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.red[200], Colors.red[500]],
                        ),
                      ),
                      accountName: new Text(name, style: TextStyle(fontSize: 15, color: Colors.white)),
                      accountEmail: new Text(email, style: TextStyle(fontSize: 15, color: Colors.white)),
                      currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl),
                          backgroundColor: Colors.transparent
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      dense: true,
                      title: Text("Home Page"),
                      leading: Icon(Icons.home),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                      },
                      dense: true,
                      title: Text("Profile Page"),
                      leading: Icon(Icons.person),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                      },
                      dense: true,
                      title: Text("Settings"),
                      leading: Icon(Icons.settings),
                    ),
                    ListTile(
                      onTap: () {
                        signOutGoogle();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
                      },
                      dense: true,
                      title: Text("Sign Out"),
                      leading: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.amber[100], Colors.amber[400]],
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
            )
          ],
        ),
      ),
    );
  }
}