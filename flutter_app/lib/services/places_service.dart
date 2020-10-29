import 'package:flutter_app/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyAUdkcL2aVa19xwNol4oGP4sgIIrUjKPbo';

  Future<List<Place>> getPlaces(double lat, double lng) async {
    var response = await http.get('https://maps.googleapis.com/maps/api/place/nerbyserch/json?location=$lat,$lng}&type=food&rankby=distance&key=$key');
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}