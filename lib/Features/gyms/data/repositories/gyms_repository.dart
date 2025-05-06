import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../models/gym_model.dart';

class GymsRepository {
  // Calculate distance between two coordinates in meters
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const Distance distance = Distance();
    return distance.as(
        LengthUnit.Meter, LatLng(lat1, lon1), LatLng(lat2, lon2));
  }

  // Get the current location of the user
  Future<Position> getCurrentLocation() async {
    try {
      // Handle different platforms
      if (kIsWeb) {
        // Web implementation
        return _getLocationForWeb();
      } else if (Platform.isAndroid || Platform.isIOS) {
        // Mobile implementation
        return _getLocationForMobile();
      } else {
        // Desktop or other platforms - use a fallback
        print('Platform not fully supported for location. Using fallback...');
        // Use Cairo, Egypt coordinates as default
        return Position(
          longitude: 31.2357,
          latitude: 30.0444,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
      }
    } catch (e) {
      print('Error getting location: $e');
      rethrow;
    }
  }

  // Get location for web platforms
  Future<Position> _getLocationForWeb() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  // Get location for mobile platforms
  Future<Position> _getLocationForMobile() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print('Error getting location on mobile: $e');
      rethrow;
    }
  }

  // Find nearby gyms using OpenStreetMap Overpass API
  Future<List<GymModel>> findNearbyGyms(double radius) async {
    try {
      // Get user's current location
      final Position position = await getCurrentLocation();

      // Build Overpass API query to find gyms
      // This searches for nodes tagged as 'leisure=fitness_centre' or 'sport=fitness' or 'leisure=sports_centre'
      final String overpassQuery = '''
        [out:json];
        (
          node["leisure"="fitness_centre"](around:${radius.toInt()},${position.latitude},${position.longitude});
          node["sport"="fitness"](around:${radius.toInt()},${position.latitude},${position.longitude});
          node["leisure"="sports_centre"](around:${radius.toInt()},${position.latitude},${position.longitude});
          way["leisure"="fitness_centre"](around:${radius.toInt()},${position.latitude},${position.longitude});
          way["sport"="fitness"](around:${radius.toInt()},${position.latitude},${position.longitude});
          way["leisure"="sports_centre"](around:${radius.toInt()},${position.latitude},${position.longitude});
          relation["leisure"="fitness_centre"](around:${radius.toInt()},${position.latitude},${position.longitude});
          relation["sport"="fitness"](around:${radius.toInt()},${position.latitude},${position.longitude});
          relation["leisure"="sports_centre"](around:${radius.toInt()},${position.latitude},${position.longitude});
        );
        out center;
      ''';

      // Make API request
      final response = await http.post(
        Uri.parse('https://overpass-api.de/api/interpreter'),
        body: overpassQuery,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> elements = data['elements'] ?? [];

        // Convert API response to GymModel objects
        final List<GymModel> gyms = [];

        for (var element in elements) {
          try {
            // For ways and relations, use the center point
            var lat = element['lat'];
            var lon = element['lon'];

            if (lat == null || lon == null) {
              // If no direct lat/lon (for ways/relations), use center
              if (element['center'] != null) {
                lat = element['center']['lat'];
                lon = element['center']['lon'];
              } else {
                continue; // Skip if no location data
              }
            }

            final gym = GymModel.fromOverpassJson(element);

            // Calculate distance from user
            final distance = _calculateDistance(position.latitude,
                position.longitude, gym.latitude, gym.longitude);

            // Create a new gym with the distance
            final gymWithDistance = GymModel(
              id: gym.id,
              name: gym.name,
              address: gym.address,
              latitude: gym.latitude,
              longitude: gym.longitude,
              phoneNumber: gym.phoneNumber,
              imageUrl: gym.imageUrl,
              distance: distance,
            );

            gyms.add(gymWithDistance);
          } catch (e) {
            // Skip invalid results
            print('Error parsing gym: $e');
          }
        }

        // Sort by distance
        gyms.sort((a, b) => (a.distance ?? double.infinity)
            .compareTo(b.distance ?? double.infinity));

        return gyms;
      } else {
        throw Exception('Failed to load gyms: ${response.statusCode}');
      }
    } catch (e) {
      print('Error finding nearby gyms: $e');
      return [];
    }
  }

  // Search for gyms by name or address using Nominatim API
  Future<List<GymModel>> searchGymsByName(String query) async {
    try {
      final Uri url = Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$query gym&format=json&limit=10');

      final response = await http.get(
        url,
        headers: {'User-Agent': 'FitApp/1.0'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => GymModel.fromNominatimJson(item)).toList();
      } else {
        throw Exception('Failed to search gyms: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching gyms: $e');
      return [];
    }
  }
}
