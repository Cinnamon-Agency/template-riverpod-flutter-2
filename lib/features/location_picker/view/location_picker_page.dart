import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:map_location_picker/map_location_picker.dart';

final mapsAPIKeyProvider = Provider((ref) => dotenv.get('GOOGLE_MAPS_API_KEY'));

class LocationPickerPage extends ConsumerWidget {
  const LocationPickerPage({required this.onLocationSelected, super.key});

  final Function(GeocodingResult) onLocationSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleMapsApiKey = ref.read(mapsAPIKeyProvider);

    return MapLocationPicker(
      apiKey: googleMapsApiKey,
      currentLatLng: const LatLng(45.7902023, 15.9706199),
      hideLocationButton: true,
      hideMapTypeButton: true,
      bottomCardColor: Colors.white,
      onNext: (location) {
        if (location != null) {
          GoRouter.of(context).pop();
          onLocationSelected(location);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location is not valid.')));
        }
      },
    );
  }
}
