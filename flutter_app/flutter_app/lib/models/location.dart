class Location{
  final double lat;
  final double lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String,dynamic> parsedJson)
  :lat = parsedJson['lat'],
  lng = parsedJson['lng'];
}