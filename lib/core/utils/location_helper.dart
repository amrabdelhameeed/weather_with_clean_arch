import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../errors/failure.dart';

class LocationHelper {
  static Future<bool> _getPremission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }
    return true;
  }

  static Future<Either<LocationFailure, Position>> getMyLocationPosition() async {
    await _getPremission().then((value) {
      if (!value) {
        return Left(LocationFailure(errorMessage: 'Premission Denied'));
      }
    });
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return Right(await Geolocator.getCurrentPosition());
  }

  static Future<Either<LocationFailure, Position>> getMyLocationByCity({required String cityName}) async {
    await _getPremission().then((value) {
      if (!value) {
        return Left(LocationFailure(errorMessage: 'Premission Denied'));
      }
    });
    late Location location;
    await GeocodingPlatform.instance.locationFromAddress(cityName).then((locations) {
      location = locations.first;
    });
    return Right(Position(longitude: location.longitude, latitude: location.latitude, timestamp: location.timestamp, accuracy: 1.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0));
  }
}
