import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/models/gym_model.dart';
import '../../data/repositories/gyms_repository.dart';

// State for the gyms cubit
class GymsState {
  final List<GymModel> gyms;
  final bool isLoading;
  final String? errorMessage;
  final Position? userLocation;

  GymsState({
    this.gyms = const [],
    this.isLoading = false,
    this.errorMessage,
    this.userLocation,
  });

  GymsState copyWith({
    List<GymModel>? gyms,
    bool? isLoading,
    String? errorMessage,
    Position? userLocation,
  }) {
    return GymsState(
      gyms: gyms ?? this.gyms,
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          errorMessage, // Null means no change or explicitly clear error
      userLocation: userLocation ?? this.userLocation,
    );
  }
}

// Cubit to manage gyms data
class GymsCubit extends Cubit<GymsState> {
  final GymsRepository _repository;

  GymsCubit(this._repository) : super(GymsState());

  // Get user's current location
  Future<void> getUserLocation() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final position = await _repository.getCurrentLocation();
      emit(state.copyWith(userLocation: position, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to get your location: ${e.toString()}',
      ));
    }
  }

  // Update user location with a provided position (for testing)
  void updateUserLocation(Position position) {
    emit(state.copyWith(userLocation: position));
  }

  // Find nearby gyms based on user's location
  Future<void> findNearbyGyms({double radius = 5000}) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      // Get user location if not already available
      if (state.userLocation == null) {
        await getUserLocation();
        // If getting location failed, return
        if (state.errorMessage != null) return;
      }

      final gyms = await _repository.findNearbyGyms(radius);
      emit(state.copyWith(gyms: gyms, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to find nearby gyms: ${e.toString()}',
      ));
    }
  }

  // Search for gyms by name
  Future<void> searchGymsByName(String query) async {
    try {
      if (query.trim().isEmpty) {
        // If query is empty, return to nearby gyms if possible
        if (state.userLocation != null) {
          await findNearbyGyms();
        }
        return;
      }

      emit(state.copyWith(isLoading: true, errorMessage: null));
      final gyms = await _repository.searchGymsByName(query);
      emit(state.copyWith(gyms: gyms, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to search gyms: ${e.toString()}',
      ));
    }
  }
}
