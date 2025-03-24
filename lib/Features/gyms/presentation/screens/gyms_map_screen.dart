import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../business_logic/gyms_cubit.dart';
import '../../data/models/gym_model.dart';
import '../../data/repositories/gyms_repository.dart';

class GymsMapScreen extends StatefulWidget {
  const GymsMapScreen({Key? key}) : super(key: key);

  @override
  State<GymsMapScreen> createState() => _GymsMapScreenState();
}

class _GymsMapScreenState extends State<GymsMapScreen> {
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();
  double _searchRadius = 5000;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLocationServices();
    });
  }

  // Initialize location services
  Future<void> _initializeLocationServices() async {
    try {
      final locationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!locationEnabled) {
        _showLocationServiceDisabledDialog();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions denied')),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationPermissionDeniedForeverDialog();
        return;
      }

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Error initializing location services: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initialize location: $e')),
      );
    }
  }

  void _showLocationServiceDisabledDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Services Disabled'),
          content: const Text(
              'Location services are disabled. Please enable location services in your device settings to use this feature.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
            ),
          ],
        );
      },
    );
  }

  void _showLocationPermissionDeniedForeverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Denied'),
          content: const Text(
              'Location permissions are permanently denied. Please enable them in your app settings.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open App Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GymsCubit(GymsRepository())..findNearbyGyms(radius: _searchRadius),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find Nearby Gyms'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        body: !_isInitialized
            ? _buildLocationPermissionError()
            : BlocConsumer<GymsCubit, GymsState>(
                listener: (context, state) {
                  if (state.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage!)),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      _buildSearchBar(context),
                      _buildRadiusSlider(context, state),
                      Expanded(
                        child: state.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : _buildMap(context, state),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  Widget _buildLocationPermissionError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Location services are required',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please enable location services to use this feature',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _initializeLocationServices();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for gyms',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              context.read<GymsCubit>().findNearbyGyms(radius: _searchRadius);
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        ),
        onSubmitted: (query) {
          context.read<GymsCubit>().searchGymsByName(query);
        },
      ),
    );
  }

  Widget _buildRadiusSlider(BuildContext context, GymsState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Text('Search Radius:'),
          Expanded(
            child: Slider(
              value: _searchRadius,
              min: 1000,
              max: 10000,
              divisions: 9,
              label: '${(_searchRadius / 1000).toStringAsFixed(1)} km',
              onChanged: (value) {
                setState(() {
                  _searchRadius = value;
                });
              },
              onChangeEnd: (value) {
                context.read<GymsCubit>().findNearbyGyms(radius: value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap(BuildContext context, GymsState state) {
    if (state.userLocation == null && state.gyms.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Unable to get your location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Check that location services are enabled in your device settings',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<GymsCubit>().getUserLocation();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    // Center position - either user's location or first gym
    LatLng centerPosition;
    if (state.userLocation != null) {
      centerPosition = LatLng(
        state.userLocation!.latitude,
        state.userLocation!.longitude,
      );
    } else if (state.gyms.isNotEmpty) {
      centerPosition = LatLng(
        state.gyms.first.latitude,
        state.gyms.first.longitude,
      );
    } else {
      centerPosition = LatLng(0, 0); // Default
    }

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: centerPosition,
            initialZoom: 14.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'graduation_project_ui',
            ),
            MarkerLayer(
              markers: [
                // User location marker
                if (state.userLocation != null)
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: LatLng(
                      state.userLocation!.latitude,
                      state.userLocation!.longitude,
                    ),
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 40.0,
                    ),
                  ),
                // Gym markers
                ...state.gyms.map(
                  (gym) => Marker(
                    width: 40.0,
                    height: 40.0,
                    point: LatLng(gym.latitude, gym.longitude),
                    child: GestureDetector(
                      onTap: () => _showGymDetails(context, gym),
                      child: const Icon(
                        Icons.fitness_center,
                        color: Colors.red,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Show gym list button
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            heroTag: 'gym_list_button',
            onPressed: () => _showGymsList(context, state.gyms),
            child: const Icon(Icons.list),
          ),
        ),
        // Refresh location button
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: FloatingActionButton(
            heroTag: 'location_refresh_button',
            onPressed: () {
              context.read<GymsCubit>().getUserLocation();
              context.read<GymsCubit>().findNearbyGyms(radius: _searchRadius);
            },
            child: const Icon(Icons.my_location),
          ),
        ),
        // Test locations button
        Positioned(
          bottom: 80.0,
          left: 16.0,
          child: FloatingActionButton(
            heroTag: 'test_locations_button',
            onPressed: () {
              _showTestLocationsMenu(context);
            },
            backgroundColor: Colors.orange,
            child: const Icon(Icons.map),
          ),
        ),
      ],
    );
  }

  void _showGymDetails(BuildContext context, GymModel gym) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gym.name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Address: ${gym.address}'),
            if (gym.phoneNumber != null) ...[
              const SizedBox(height: 4.0),
              Text('Phone: ${gym.phoneNumber}'),
            ],
            if (gym.distance != null) ...[
              const SizedBox(height: 4.0),
              Text(
                'Distance: ${(gym.distance! / 1000).toStringAsFixed(2)} km',
              ),
            ],
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to directions (could open maps app)
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.directions),
                  label: const Text('Directions'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Save gym to favorites
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.favorite_border),
                  label: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showGymsList(BuildContext context, List<GymModel> gyms) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nearby Gyms',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: gyms.length,
                itemBuilder: (context, index) {
                  final gym = gyms[index];
                  return ListTile(
                    title: Text(gym.name),
                    subtitle: Text(gym.address),
                    trailing: gym.distance != null
                        ? Text(
                            '${(gym.distance! / 1000).toStringAsFixed(2)} km')
                        : null,
                    onTap: () {
                      // Close bottom sheet
                      Navigator.pop(context);
                      // Center map on this gym
                      _mapController.move(
                        LatLng(gym.latitude, gym.longitude),
                        15.0,
                      );
                      // Show details
                      _showGymDetails(context, gym);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTestLocationsMenu(BuildContext context) {
    final GymsCubit gymsCubit = context.read<GymsCubit>();

    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Test Location',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              title: const Text('New York'),
              subtitle: const Text('USA'),
              onTap: () {
                _setTestLocation(gymsCubit, 40.7128, -74.0060);
                Navigator.pop(bottomSheetContext);
              },
            ),
            ListTile(
              title: const Text('London'),
              subtitle: const Text('UK'),
              onTap: () {
                _setTestLocation(gymsCubit, 51.5074, -0.1278);
                Navigator.pop(bottomSheetContext);
              },
            ),
            ListTile(
              title: const Text('Tokyo'),
              subtitle: const Text('Japan'),
              onTap: () {
                _setTestLocation(gymsCubit, 35.6762, 139.6503);
                Navigator.pop(bottomSheetContext);
              },
            ),
            ListTile(
              title: const Text('Cairo'),
              subtitle: const Text('Egypt'),
              onTap: () {
                _setTestLocation(gymsCubit, 30.0444, 31.2357);
                Navigator.pop(bottomSheetContext);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _setTestLocation(GymsCubit cubit, double latitude, double longitude) {
    final Position mockPosition = Position(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );

    // Move map to this location
    _mapController.move(LatLng(latitude, longitude), 14.0);

    // Update state in cubit with mock position
    cubit.updateUserLocation(mockPosition);
    cubit.findNearbyGyms(radius: _searchRadius);
  }
}
