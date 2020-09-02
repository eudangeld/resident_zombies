import 'package:google_maps_flutter/google_maps_flutter.dart';

enum Gender { male, female, other }

class User {
  final String name;
  final String id;
  final int age;
  final String gender;
  final LatLng lastLocation;
  final bool infected;
  final String createdAt;
  final String updatedAt;

  User({
    this.updatedAt,
    this.infected,
    this.createdAt,
    this.name,
    this.id,
    this.age,
    this.gender,
    this.lastLocation,
  });

  @override
  String toString() {
    print('Name:$name');
    print('id:$id');
    print('age:$age');
    print('gender:$gender');
    print('lastLocation:$lastLocation');
    print('infected:$infected');
    print('createdAt:$createdAt');
    print('updatedAt:$updatedAt');
    return super.toString();
  }
}
