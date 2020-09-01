import 'package:google_maps_flutter/google_maps_flutter.dart';

enum Gender { male, female, other }

class User {
  final String name;
  final String id;
  final int age;
  final Gender gender;
  final LatLng lastLocation;

  User({
    this.name,
    this.id,
    this.age,
    this.gender,
    this.lastLocation,
  });
}
