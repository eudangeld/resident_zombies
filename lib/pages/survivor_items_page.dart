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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeArgs = ModalRoute.of(context).settings.arguments;
    print('getting route args');
    print(routeArgs);
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
                itemBuilder: (context, index) => ListTile(
                  title: Text(_data[index]['item']['name'] +
                      'X' +
                      _data[index]['quantity'].toString()),
                  trailing: Column(
                    children: <Widget>[
                      Text('Custo/Und'),
                      Text(_data[index]['item']['points'].toString()),
                    ],
                  ),
                ),
              );
            }
            return Loading();
          }),
    );
  }
}
