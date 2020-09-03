import 'package:flutter/material.dart';
import 'package:resident_zombies/util/helper.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';

class SurvivorItemsPage extends StatefulWidget {
  static String get routeName => '@routes/survivor_items_page';

  @override
  _SurvivorItemsPageState createState() => _SurvivorItemsPageState();
}

class _SurvivorItemsPageState extends State<SurvivorItemsPage> {
  dynamic routeArgs;

  /// Used to indicate icons path on assets folder
  ///
  /// TODO: Refactory when possible
  final _assetsMap = {
    'Fiji Water': 'assets/itens/water.png',
    'First Aid Pouch': 'assets/itens/aid.png',
    'AK47': 'assets/itens/ak.png',
    'Campbell Soup': 'assets/itens/soup.png',
  };

  /// Get [id] from routeArgments and call userData
  ///
  /// If [id] is null use player [id] itself
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeArgs = ModalRoute.of(context).settings.arguments ??
        state(context).user.value.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: FutureBuilder(
          future: api(context).getSurvivorItems(routeArgs),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> _data = snapshot.data as List<dynamic>;
              return ListView.builder(
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
                    subtitle: Text(
                        'Disponível: ' + _data[index]['quantity'].toString()),
                    leading: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                            _assetsMap[_data[index]['item']['name']])),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Preço/Und'),
                        Text(_data[index]['item']['points'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Loading();
          }),
    );
  }
}
