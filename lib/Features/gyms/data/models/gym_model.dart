class GymModel {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? imageUrl;
  final String? phoneNumber;
  final double? distance; // Distance in meters from user's location

  GymModel({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.imageUrl,
    this.phoneNumber,
    this.distance,
  });

  // Create from OpenStreetMap Overpass API response
  factory GymModel.fromOverpassJson(Map<String, dynamic> json) {
    final Map<String, dynamic> tags = json['tags'] ?? {};
    return GymModel(
      id: json['id'].toString(),
      name: tags['name'] ?? 'Unnamed Gym',
      address: [
        tags['addr:housenumber'],
        tags['addr:street'],
        tags['addr:city'],
      ].where((element) => element != null).join(', '),
      latitude: json['lat'],
      longitude: json['lon'],
      phoneNumber: tags['phone'],
      imageUrl: null, // OpenStreetMap doesn't directly provide images
    );
  }

  // Create from Nominatim API response (for search by name/address)
  factory GymModel.fromNominatimJson(Map<String, dynamic> json) {
    return GymModel(
      id: json['osm_id'].toString(),
      name: json['name'] ?? json['display_name'] ?? 'Unnamed Gym',
      address: json['display_name'] ?? '',
      latitude: double.parse(json['lat']),
      longitude: double.parse(json['lon']),
      phoneNumber: null,
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'distance': distance,
    };
  }
}
