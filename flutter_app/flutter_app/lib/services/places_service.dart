import 'package:flutter_app/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:provider/provider.dart';

class PlacesService {
  final key = 'AIzaSyAUdkcL2aVa19xwNol4oGP4sgIIrUjKPbo';

  Future<List<Place>> getPlaces(double lat, double lng,) async {
      var response = await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location='+lat.toString()+','+lng.toString()+'&radius=17600&type=restaurant&key=$key');
      var json = convert.jsonDecode(response.body);
      var jsonResults = json['results'] as List;
      return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}