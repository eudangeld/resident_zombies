import 'package:resident_zombies/model/user.dart';
import 'package:resident_zombies/widgets/trade_itens_quantity.dart';

/// Used to encapsulate trade option
///
/// All needed params used to trade itens
/// will be here
class Tradeoptions {
  /// Itens that user WANT after current trade
  ///
  final List<ItensStepper> wantedItens;

  /// Itens used to PAY current Trade
  ///
  final List<ItensStepper> sendingItens;

  ///Target user [survivorUUID]
  final String survivorUUID;

  Map<dynamic, dynamic> prepareToApi() {
    assert(sendingItens != null);
    assert(wantedItens != null);
    assert(survivorUUID != null);
    assert(player != null);
    assert(sendingItens.isNotEmpty);
    assert(wantedItens.isNotEmpty);

    return {
      'person_id': survivorUUID,
      'consumer': {
        'name': player.name,
        'pick': sendingItens
            .map((e) => e.currentItem)
            .toList()
            .map((e) => e.name + ':' + e.units.toString())
            .join(';'),
        'payment': sendingItens
            .map((e) => e.currentItem)
            .toList()
            .map((e) => e.name + ':' + e.units.toString())
            .join(';'),
      }
    };
  }

  ///Player [User]
  ///its just to avoid verbosity when call state(context)....
  ///
  final User player;

  Tradeoptions({
    this.wantedItens,
    this.sendingItens,
    this.survivorUUID,
    this.player,
  });
}
