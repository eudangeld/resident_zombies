import 'package:flutter/foundation.dart';

class ItemDetail {
  // Iten name
  final String name;

  /// Toal units sending or receiving
  ///
  /// never can greater than [maxAvaliables]
  int units;

  /// Total points per unit
  ///
  /// used to billl
  final int points;

  //max itens avaliables
  final int maxAvaliables;

  ItemDetail({
    @required this.points,
    @required this.name,
    @required this.maxAvaliables,
    @required this.units,
  });
}
