import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/home_page.dart';
import 'package:flutter_app/Screens/login_page.dart';
import 'package:flutter_app/services/geolocator_service.dart';
import 'package:flutter_app/services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'models/place.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position,Future<List<Place>>>(
          update: (context,position,places){
            return (position != null) ? placesService.getPlaces(position.latitude, position.longitude) : null;
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IDC You Pick',
        theme: ThemeData(
          primaryColor: Colors.redAccent,
        ),
        home: new LoginPage(),
      ),
    );
  }
}