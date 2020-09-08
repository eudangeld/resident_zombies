import 'package:dio/dio.dart';
import 'package:dio/src/options.dart';
import 'package:dio/src/response.dart';
import 'package:resident_zombies/api/base_request.dart';
import 'package:resident_zombies/model/user.dart';
import 'package:resident_zombies/widgets/trade_itens_quantity.dart';

/// Used to encapsulate trade option
///
/// All needed params used to trade itens
/// will be here
///
/// [personId] Survivor UUID
/// [consumerName] Recipient of the transaction full name
/// [consumerPick] The list of items and quantities WANTED, in the format 'Fiji Water:10;Campbell Soup:5'
/// [consumerPayment] The list of items and quantities to PAY IN RETURN, in the format 'Fiji Water:5;Campbell Soup:10'
class Tradeoptions extends AppRequest {
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

  @override
  BaseOptions get options => options;

  @override
  prepare() {
    if (validate()) {
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
    } else {
      print('Object not validated');
    }
  }

  @override
  String get serviceUri => serviceUri;

  @override
  bool validate() {
    assert(sendingItens != null);
    assert(wantedItens != null);
    assert(survivorUUID != null);
    assert(player != null);
    assert(sendingItens.isNotEmpty);
    assert(wantedItens.isNotEmpty);

    if (sendingItens != null &&
        wantedItens != null &&
        survivorUUID != null &&
        player != null &&
        sendingItens.isNotEmpty &&
        wantedItens.isNotEmpty) {
      return true;
    }

    return false;
  }

  @override
  Future<Response> call() async {
    final dio = Dio();
    Response _response;
    final _body = prepare();

    /// URI for service
    final _apiUri =
        'http://zssn-backend-example.herokuapp.com/api/people/${survivorUUID}/properties/trade_item';

    try {
      _response = _response = await dio.post(_apiUri, data: _body);
    } on DioError catch (error) {
      _response = error.response;
    }

    return _response;
  }
}
