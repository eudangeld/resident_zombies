import 'package:flutter/material.dart';
import 'package:resident_zombies/model/trade_item_details.dart';
import 'package:resident_zombies/theme/global_theme.dart';
import 'package:resident_zombies/util/helper.dart';
import 'package:resident_zombies/widgets/bottom_sheet_button.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';

class TradeDetailsPage extends StatelessWidget {
  static String get routeName => '@routes/itens_quantity';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: BottomSheetButton(
          label: 'Adicionar',
          onPressed: () => print('adicionando item na sacola'),
        ),
        appBar: AppBar(
          title: Text('Detalhes da troca'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.filled(5,
                      Icon(Icons.arrow_back, size: 40, color: Colors.green))),
            ),

            /// Survivor itens
            ///
            ///
            itenDetailsWidget(context, state(context).traderId),

            Padding(padding: const EdgeInsets.all(20.0), child: Divider()),

            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.filled(5,
                      Icon(Icons.arrow_forward, size: 40, color: Colors.red))),
            ),

            /// Player itens
            ///
            itenDetailsWidget(context, state(context).user.value.id),

            SizedBox(height: 120)
          ]),
        ));
  }

  /// Show current player itens
  Widget itenDetailsWidget(BuildContext context, String id) {
    return Container(
      child: FutureBuilder(
          future: api(context).getSurvivorItems(id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            }

            final bool _playerItens = state(context).user.value.id == id;

            List<dynamic> _data = snapshot.data as List<dynamic>;

            String _emptyMessage = _playerItens
                ? 'Você está sem nenhum ítem, melhor você fazer alguma coisa antes que seja tarde!'
                : 'Sobrevivente sem nenhum ítem, não vai durar muito tempo até ser infectado';

            return _data.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 50, bottom: 30),
                    child: Text(
                      _emptyMessage,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                : Column(
                    children: _data
                        .map((item) => ItensStepper(
                            iconPath: item['item']['name'],
                            currentItem: ItemDetail(
                                points: item['item']['points'],
                                name: item['item']['name'],
                                maxAvaliables: item['quantity'],
                                units: 0)))
                        .toList(),
                  );
          }),
    );
  }
}

// ignore: must_be_immutable
class ItensStepper extends StatefulWidget {
  ItemDetail currentItem;
  final String iconPath;

  ItensStepper({Key key, @required this.currentItem, @required this.iconPath})
      : super(key: key);

  @override
  _ItensStepperState createState() => _ItensStepperState();
}

class _ItensStepperState extends State<ItensStepper> {
  void incrementunits(ItemDetail item, BuildContext context) {
    if (item.units + 1 > item.maxAvaliables) {
      item.units = 0;
    } else {
      item.units++;
    }
    setState(() => widget.currentItem = item);
  }

  void decrementValues(ItemDetail item, BuildContext context) {
    if (item.units - 1 <= 0) {
      item.units = item.maxAvaliables;
    } else {
      item.units--;
    }
    setState(() => widget.currentItem = item);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '${widget.currentItem.name}',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        Row(
          children: <Widget>[
            // Container(height: 50, width: 50, child: Image.asset(iconPath)),
            IconButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () => decrementValues(widget.currentItem, context),
              icon: Icon(Icons.remove),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      widget.currentItem.units.toString(),
                      style: TextStyle(
                        color: heavyDark,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () => incrementunits(widget.currentItem, context),
              icon: Icon(Icons.add),
            ),
          ],
        )
      ],
    );
  }
}
