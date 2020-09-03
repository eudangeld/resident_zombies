import 'package:flutter/material.dart';
import 'package:resident_zombies/model/trade_item_details.dart';
import 'package:resident_zombies/util/helper.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';
import 'package:resident_zombies/widgets/trade_itens_quantity.dart';

class SurvivorItemsPage extends StatefulWidget {
  static String get routeName => '@routes/survivor_items_page';

  @override
  _SurvivorItemsPageState createState() => _SurvivorItemsPageState();
}

class _SurvivorItemsPageState extends State<SurvivorItemsPage> {
  dynamic routeArgs;

  ///[true] if data is from current player
  /// add specifc styles and logic like no trade with me :(
  bool _playerItens = false;

  /// Get [id] from routeArgments and call userData
  ///
  /// If [id] is null use player [id] itself
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _playerItens = ModalRoute.of(context).settings.arguments == null;
    routeArgs = ModalRoute.of(context).settings.arguments ??
        state(context).user.value.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_playerItens ? 'Meus ítens' : lz(context).itensTitle),
      ),
      body: FutureBuilder(
          future: api(context).getSurvivorItems(routeArgs),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> _data = snapshot.data as List<dynamic>;

              String _emptyMessage = _playerItens
                  ? 'Você está sem nenhum ítem, melhor você fazer alguma coisa antes que seja tarde!'
                  : 'Sobrevivente sem nenhum ítem, não vai durar muito tempo até ser infectado';
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 50, bottom: 30),
                    child: Text(
                      lz(context).intensSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(),
                  _data.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 50, bottom: 30),
                          child: Text(
                            _emptyMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _data.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ListTile(
                              isThreeLine: true,
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  _data[index]['item']['name'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text('Disponível: ' +
                                  _data[index]['quantity'].toString()),
                              leading: Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset(state(context).assetsMap[
                                      _data[index]['item']['name']])),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Preço/Und'),
                                  Text(
                                      _data[index]['item']['points'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              );
            }
            return Loading();
          }),
    );
  }
}
