import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resident_zombies/util/helper.dart';

enum Gender { male, female, other }

class User {
  final String name;
  final String id;
  final int age;
  final String gender;
  LatLng lastLocation;
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? getIdFromLocation(json['location']),
      lastLocation: strToCrdinates(json['lonlat'] as String) ??
          LatLng(-23.623660, -46.695790),
      name: json['name'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      infected: json['infected'] as bool,
    );
  }

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
