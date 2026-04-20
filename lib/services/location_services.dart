import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationManager {
  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<Position> getCoordinates() async {
    final hasPermission = await requestPermission();

    if (!hasPermission) {
      throw Exception('Location permission denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getCityFromCoordinates({
    required double lat,
    required double lon,
  }) async {
    final placemarks = await placemarkFromCoordinates(lat, lon);

    if (placemarks.isEmpty) {
      throw Exception('No placemark found');
    }

    final place = placemarks.first;

    return place.locality ??
        place.subAdministrativeArea ??
        place.administrativeArea ??
        'Unknown';
  }

  Future<Position> resolveLocation() async {
    final position = await getCoordinates();

    return position;
  }

  Future<String> resolveCity() async {
    final position = await getCoordinates();

    final city = await getCityFromCoordinates(
      lat: position.latitude,
      lon: position.longitude,
    );

    return city;
  }
}