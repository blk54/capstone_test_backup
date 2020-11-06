import 'package:flutter_app/models/location.dart';

class Geometry{
  final Location location;

  Geometry({this.location});

  Geometry.fromJson(Map<String,dynamic> parsedJson)
  :location = Location.fromJson(parsedJson['location']);
}