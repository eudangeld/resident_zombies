import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resident_zombies/model/user.dart';
import 'package:rxdart/subjects.dart';

import 'trade_item_details.dart';

class AppState {
  /// Default app location
  ///
  /// [Codeminer42 SP location]
  /// Used when geolocator plugin throws an exception
  /// or u need some location and dant want to think wich location use
  final codeminerLocation = LatLng(-23.623660, -46.695790);

  /// Use that value to show position on maps
  /// Deafults to [Codeminer42 SP location]
  // ignore: close_sinks
  final currentMapPosition =
      BehaviorSubject<LatLng>.seeded(LatLng(-23.623660, -46.695790));

  ///current [User] on state
  ///last registered
  // ignore: close_sinks
  final user = BehaviorSubject<User>.seeded(User());

  /// Indicate other player [id]
  ///
  /// used to retrieve and send itens between player and this survivor
  String traderId;

  /// Used to indicate icons path on assets folder
  ///
  /// TODO: Refactory when possible
  final assetsMap = {
    'Fiji Water': 'assets/itens/water.png',
    'First Aid Pouch': 'assets/itens/aid.png',
    'AK47': 'assets/itens/ak.png',
    'Campbell Soup': 'assets/itens/soup.png',
  };

  ///Player itens
  ///
  ///
  /// used to pay trade
  final currentPlayerItens = BehaviorSubject<List<ItemDetail>>.seeded(null);

  ///Trader survivor itens
  ///
  ///
  /// indicate other players itens to trade
  final otherPlayerItens = BehaviorSubject<List<ItemDetail>>.seeded(null);
}
