import 'dart:core';

class Api {
  String baseUrl = 'http://zssn-backend-example.herokuapp.com/';

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

  /// Register a new survivor
  ///
  ///[POST]
  ///Register new survivor
  ///Receive a Person with its Inventory of Items
  Future<void> register() {}

  /// [GET]
  /// String [id] Person UUID
  /// Fetch a single survivor
  Future<void> getSurvivor() {}

  ///[PATH]
  ///Update survivor
  ///Used to update on survivor
  Future<void> updateSurvivor() {}
}
