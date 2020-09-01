import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api {
  /// TODO: come from a .env file
  /// Use if u need to acces outside of this class
  static final String baseUrl = 'http://zssn-backend-example.herokuapp.com';
  final _dio = Dio();

  /// Trade an item
  ///
  /// [personId] Survivor UUID
  /// [consumerName] Recipient of the transaction full name
  /// [consumerPick] The list of items and quantities WANTED, in the format 'Fiji Water:10;Campbell Soup:5'
  /// [consumerPayment] The list of items and quantities to PAY IN RETURN, in the format 'Fiji Water:5;Campbell Soup:10'
  Future<void> tradeItem() {}

  ///Returns a list of items belonging to a Person
  /// [GET]
  /// [personId] Survivor UUID
  Future<void> properties(personId) {}

  ///return of infected people
  ///[GET]
  Future<void> infected() {}

  ///[GET]
  ///Average of non-infected (healthy) people
  Future<void> nonInfected() {}

  ///[GET]
  ///Average of the quantity of items per person (total and just non-infected) and of each item
  /// people_inventory
  Future<void> peopleInventory() {}

  ///[GET]
  ///Total points lost in items that belong to infected people
  Future<void> infectedPoints() {}

  ///[GET]
  ///List of the Available Reports
  Future<void> report() {}

  ///Used to increase the infection count of a Person
  ///String [infected]	 Person UUID with the infection suspect
  ///String [id]	 Person UUID with the infection suspect
  Future<void> reportInfection() {}

  ///[GET]
  ///Fetches all survivors
  ///Implementation Notes
  Future<void> getAll() {}

  ///Register a new survivor
  ///curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' -d 'person%5Bname%5D=dsadd&person%5Bage%5D=10.0&person%5Bgender%5D=m&items=dsadd%3Bdas' 'http://zssn-backend-example.herokuapp.com//zssn-backend-example.herokuapp.com/api/people.json'

  ///
  ///[POST]
  ///Required [String name] Required [int Age] Required [String gender]
  ///Inventory Items required [items String ] in the format 'Fiji Water:10;Campbell Soup:5'
  Future<void> register({
    @required String name,
    @required int age,
    @required String gender,
    @required String items,
  }) async {
    //TODO:TREAT REPONSE ERERORS
    Map<dynamic, dynamic> body = {
      'items': 'Fiji Water:10',
      'person': {
        'name': name,
        'age': age,
        'gender': gender,
      }
    };

    _dio.options.contentType = Headers.formUrlEncodedContentType;
    final _result = await _dio.post(
        "http://zssn-backend-example.herokuapp.com/api/people",
        data: body,
        options: Options(contentType: Headers.formUrlEncodedContentType));

    print(_result.data);
  }

  /// [GET]
  /// String [id] Person UUID
  /// Fetch a single survivor
  Future<void> getSurvivor() {}

  ///[PATH]
  ///Update survivor
  ///Used to update on survivor
  Future<void> updateSurvivor() {}
}
