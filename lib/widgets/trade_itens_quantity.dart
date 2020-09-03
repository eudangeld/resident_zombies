import 'package:flutter/material.dart';
import 'package:resident_zombies/model/trade_item_details.dart';
import 'package:resident_zombies/theme/global_theme.dart';
import 'package:resident_zombies/util/helper.dart';
import 'package:resident_zombies/widgets/bottom_sheet_button.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';
import 'package:rxdart/subjects.dart';

class TradeDetailsPage extends StatelessWidget {
  static String get routeName => '@routes/itens_quantity';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: BottomSheetButton(
          label: 'Continuar',
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

            if (_data.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 50, bottom: 30),
                child: Text(
                  _emptyMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            }
            final _steppers = _data.map((item) {
              final BehaviorSubject<int> _bhsv = BehaviorSubject<int>.seeded(0);
              return ItensStepper(
                  streamTotal: _bhsv,
                  iconPath: item['item']['name'],
                  baseColor: _playerItens ? Colors.red : Colors.green,
                  currentItem: ItemDetail(
                      points: item['item']['points'],
                      name: item['item']['name'],
                      maxAvaliables: item['quantity'],
                      units: 0));
            }).toList();

            return Column(
                children: []
                  ..add(TotalPOintsIndicator(
                      baseColor: _playerItens ? Colors.red : Colors.green,
                      steppers: _steppers))
                  ..addAll(_steppers));
          }),
    );
  }
}

// This class get the total point involved in the current transaction
// ignore: must_be_immutable
class TotalPOintsIndicator extends StatefulWidget {
  final List<ItensStepper> steppers;
  final Color baseColor;

  const TotalPOintsIndicator(
      {Key key, @required this.steppers, @required this.baseColor})
      : super(key: key);

  @override
  _TotalPOintsIndicatorState createState() => _TotalPOintsIndicatorState();
}

class _TotalPOintsIndicatorState extends State<TotalPOintsIndicator> {
  @override
  void initState() {
    super.initState();
    widget.steppers.forEach((element) {
      element.streamTotal.listen((event) {
        total = 0;
        widget.steppers.forEach((e) {
          setState(() {
            total += e.streamTotal.value;
          });
        });
      });
    });
  }

  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 15),
      child: Column(
        children: <Widget>[
          Text('TOTAL',
              style: TextStyle(
                  color: widget.baseColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          Text(total.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class ItensStepper extends StatefulWidget {
  ItemDetail currentItem;
  final String iconPath;
  final Color baseColor;

  // ignore: close_sinks
  final BehaviorSubject<int> streamTotal;

  ItensStepper(
      {Key key,
      @required this.currentItem,
      @required this.iconPath,
      @required this.streamTotal,
      @required this.baseColor})
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
    widget.streamTotal.add(item.units * item.points);
    setState(() => widget.currentItem = item);
  }

  void decrementValues(ItemDetail item, BuildContext context) {
    if (item.units - 1 < 0) {
      item.units = item.maxAvaliables;
    } else {
      item.units--;
    }
    widget.streamTotal.add(item.units * item.points);
    setState(() => widget.currentItem = item);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '${widget.currentItem.name}',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: widget.baseColor),
        ),
        Row(
          children: <Widget>[
            IconButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () => decrementValues(widget.currentItem, context),
              icon: Icon(
                Icons.remove,
                color: widget.baseColor,
              ),
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
                        color: widget.baseColor,
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
              icon: Icon(
                Icons.add,
                color: widget.baseColor,
              ),
            ),
          ],
        )
      ],
    );
  }
}
