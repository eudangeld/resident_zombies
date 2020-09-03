import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:resident_zombies/model/user.dart';

class Api {
  Dio _dio;
  Api() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    // _dio.options.contentType = Headers.formUrlEncodedContentType;
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print('ON REQUEST');
      print(options.uri);
      print(options.data);
      print(options.headers);
      print(options.extra);
      print(options.method);
      return options;
    }, onResponse: (Response response) async {
      print('ON RESPONSE');
      print(response.data);
      print(response.statusMessage);
      print(response.statusCode);
      print(response.extra);
      return response;
    }, onError: (DioError e) async {
      print('ON ERROR');

      print(e.error);
      print(e.request);
      print(e.message);
      return e;
    }));
  }

  /// TODO: come from a .env file
  /// Use if u need to acces outside of this class
  static final String baseUrl = 'http://zssn-backend-example.herokuapp.com';

  /// Trade an item
  ///
  /// [personId] Survivor UUID
  /// [consumerName] Recipient of the transaction full name
  /// [consumerPick] The list of items and quantities WANTED, in the format 'Fiji Water:10;Campbell Soup:5'
  /// [consumerPayment] The list of items and quantities to PAY IN RETURN, in the format 'Fiji Water:5;Campbell Soup:10'
  Future<void> tradeItem() {
    //   wget --no-check-certificate --quiet \
    // --method POST \
    // --timeout=0 \
    // --header '' \
    // --body-data 'person_id=a922cf1c-12da-48a6-a4ed-fc6a5fd18934&consumer[name]=Dealer&consumer[pick]=First Aid Pouch:2;&consumer[payment]=First Aid Pouch:2;' \
    //  'http://zssn-backend-example.herokuapp.com/api/people/866ff6d5-5043-4ce0-8b21-9b17edc3ae6a/properties/trade_item'
  }

  ///Returns a list of items belonging to a Person
  /// [GET]
  /// [personId] Survivor UUID
  Future<void> properties(personId) {}

  ///return of infected people
  ///[GET]
  Future<void> infected() {}

  ///[GET]
  ///Average of non-infected (healthy) people
  Future<void> getHealth() async {
    final dio = Dio();
    final _result = await dio.get(
        'http://zssn-backend-example.herokuapp.com/api/report/non_infected');

    print(_result.data);
  }

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
  Future<dynamic> getAll() async {
    final dio = Dio();
    final _rresult =
        await dio.get('http://zssn-backend-example.herokuapp.com/api/people');

    return _rresult.data;
  }

  ///Fetches all survivors Itens
  ///
  ///[GET]
  ///Use [person_id] to retrieve all itens information from
  Future<dynamic> getSurvivorItems(String person_id) async {
    final dio = Dio();
    final _result = await dio.get(
        'http://zssn-backend-example.herokuapp.com/api/people/$person_id/properties');

    return _result.data;
  }

  ///
  ///[POST]
  ///Required [String name] Required [int Age] Required [String gender]
  ///Inventory Items required [items String ] in the format 'Fiji Water:10;Campbell Soup:5'
  Future<dynamic> register({
    @required String name,
    @required int age,
    @required String gender,
    @required String items,
  }) async {
    //TODO:TREAT REPONSE ERERORS
    Map<dynamic, dynamic> body = {
      'items': 'Fiji Water:10;Campbell Soup:5;First Aid Pouch:5; AK47:10',
      'person': {
        'name': name,
        'age': age,
        'gender': gender,
      }
    };

    try {
      final _result = await _dio.post(
          "http://zssn-backend-example.herokuapp.com/api/people",
          data: body,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      return _result.data;
    } catch (e) {
      //TODO :FIND NEW ROADS
      return null;
    }
  }

  /// [GET]
  /// String [id] Person UUID
  /// Fetch a single survivor
  Future<dynamic> getSurvivor(String id) async {
    final dio = Dio();
    final _result = await dio
        .get("http://zssn-backend-example.herokuapp.com/api/people/$id");
    print(_result.data);
    return _result.data;
  }

  ///[PATH]
  ///Update survivor
  ///Used to update on survivor
  Future<dynamic> updateSurvivor(User user) async {
    Map<dynamic, dynamic> body = {
      'person': {
        'name': user.name,
        'age': user.age,
        'gender': user.gender,
        'lonlat':
            'POINT(${user.lastLocation.latitude} ${user.lastLocation.longitude})',
      }
    };
    final dio = Dio();
    final _result = await dio.patch(
        "http://zssn-backend-example.herokuapp.com/api/people/${user.id}",
        data: body);
    return _result.data;
  }
}
