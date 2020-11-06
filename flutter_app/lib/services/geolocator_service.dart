import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class GeoLocatorService{
  Position _currentLocation;
  var location = Location();
  Future<Position> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = Position(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _currentLocation;
  }
}