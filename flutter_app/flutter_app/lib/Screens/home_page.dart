import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/profile_page.dart';
import 'package:flutter_app/models/location.dart';
import 'package:flutter_app/services/geolocator_service.dart';
import 'package:flutter_app/services/marker_service.dart';
import 'package:flutter_app/services/places_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/place.dart';
import 'package:flutter_app/Screens/sign_in.dart';
import 'package:flutter_app/Screens/settings_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
        appBar: new AppBar(
        title: new Text("Home Page"),
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
                      accountName: new Text(name, style: TextStyle(
                          fontSize: 15, color: Colors.white)),
                      accountEmail: new Text(email, style: TextStyle(
                          fontSize: 15, color: Colors.white)),
                      currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl),
                          backgroundColor: Colors.transparent
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => HomePage()));
                      },
                      dense: true,
                      title: Text("Home Page"),
                      leading: Icon(Icons.home),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProfilePage()));
                      },
                      dense: true,
                      title: Text("Profile Page"),
                      leading: Icon(Icons.person),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                      },
                      dense: true,
                      title: Text("Settings"),
                      leading: Icon(Icons.settings),
                    ),
                    ListTile(
                      onTap: () {
                        signOutGoogle();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }), ModalRoute.withName('/'));
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
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
          builder: (_, places, __) {
            var markers = (places != null) ? markerService.getMarkers(places) : List<Marker>();
            return (places != null) ? Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(currentPosition.latitude, currentPosition.longitude),
                        zoom: 16.0),
                    zoomGesturesEnabled: true,
                    markers: Set<Marker>.of(markers),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return FutureProvider(
                          create: (context) => geoService.getDistance(
                              currentPosition.latitude, currentPosition.longitude,
                              places[index].geometry.location.lat, places[index].geometry.location.lng),
                          child: Card(
                            child: ListTile(
                              title: Text(places[index].name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 3.0),
                                  (places[index].rating != null) ? Row(children: <Widget>[
                                      RatingBarIndicator(
                                        rating: places[index].rating,
                                        itemBuilder: (context, index) => Icon(Icons.star, color:Colors.amber),
                                        itemCount: 5,
                                        itemSize: 12.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ) : Row(),
                                  SizedBox(height: 3.0),
                                  Consumer<double>(
                                    builder: (context, meters, widget) {
                                      return (meters != null)
                                          ?Text('${places[index].vicinity} \u00b7 ${(meters/1609).round()}')
                                          : Container();
                                    },
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.directions),
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  _launchMapsUrl(places[index].geometry.location.lat, places[index].geometry.location.lng);
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ) : Center(child: CircularProgressIndicator());
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _launchMapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)){
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

}