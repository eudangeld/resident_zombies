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
