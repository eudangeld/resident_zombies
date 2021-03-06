import 'package:flutter/material.dart';
import 'package:resident_zombies/model/trade_item_details.dart';
import 'package:resident_zombies/model/trade_options.dart';
import 'package:resident_zombies/pages/trade_result_page.dart';
import 'package:resident_zombies/util/alerts.dart';
import 'package:resident_zombies/util/helper.dart';
import 'package:resident_zombies/widgets/bottom_sheet_button.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';
import 'package:rxdart/subjects.dart';

class TradeDetailsPage extends StatelessWidget {
  static String get routeName => '@routes/itens_quantity';

  /// This strewans will store the sum from trade
  /// and will used when user tap CTA bottomSheetButtonm
  ///
  // ignore: close_sinks
  final _requiredItensTotalPoints = BehaviorSubject<int>.seeded(0);
  // ignore: close_sinks
  final _paymentTotalPoints = BehaviorSubject<int>.seeded(0);

  ///playerItens used to create query string on api trade call
  ///
  ///
  List<ItensStepper> _playerSteppers;

  ///trader itens stepper used to create query string on api trade call
  ///
  ///
  List<ItensStepper> _traderSteppers;

  makeTrade(BuildContext context) {
    /// create trader itens List
    /// send only itens with units > 0
    final _traderList = _traderSteppers
        .where((element) => element.currentItem.units > 0)
        .toList(); // LOL

    /// create player itens List
    ////// send only itens with units > 0
    final _playerList = _playerSteppers
        .where((element) => element.currentItem.units > 0)
        .toList();

    /// Show an alert to user
    /// if accept than call api trade
    /// Send data using [TradeOptions] class
    ///
    confirmTradeAlert(
        context,
        () => api(context)
                .tradeItem(Tradeoptions(
                    player: state(context).user.value,
                    sendingItens: _playerList,
                    wantedItens: _traderList,
                    survivorUUID: state(context).traderId))
                .then((value) {
              Navigator.of(context)
                  .pushNamed(TradeResultPage.routeName, arguments: value);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: AdvanceTRadeButton(
          playerTotal: _paymentTotalPoints,
          requiredTotal: _requiredItensTotalPoints,
          onTap: () => makeTrade(context),
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
                    children: List.filled(
                        5,
                        Icon(Icons.arrow_back,
                            size: 40, color: Colors.green)))),

            /// Survivor itens
            ///
            ///
            itenDetailsWidget(
                context, state(context).traderId, _requiredItensTotalPoints),

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
            itenDetailsWidget(
                context, state(context).user.value.id, _paymentTotalPoints),

            SizedBox(height: 120)
          ]),
        ));
  }

  /// Show current player itens
  Widget itenDetailsWidget(
      BuildContext context, String id, BehaviorSubject totalStream) {
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
                ? lz(context).noOneItens
                : lz(context).survivorWithNoItensmessage;

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
              return ItensStepper(
                  streamTotal: BehaviorSubject<int>.seeded(0),
                  iconPath: item['item']['name'],
                  baseColor: _playerItens ? Colors.red : Colors.green,
                  currentItem: ItemDetail(
                      points: item['item']['points'],
                      name: item['item']['name'],
                      maxAvaliables: item['quantity'],
                      units: 0));
            }).toList();

            /// put steppers on top level array
            /// to build query string when advance
            _playerItens
                ? _playerSteppers = _steppers
                : _traderSteppers = _steppers;

            return Column(
                children: []
                  ..add(TotalPOintsIndicator(
                      total: totalStream,
                      baseColor: _playerItens ? Colors.red : Colors.green,
                      steppers: _steppers))
                  ..addAll(_steppers));
          }),
    );
  }
}

///
/// a button that just verify the possbility to trade
///
/// receive from [TradeDetailsPage] the trade values
/// [required] represents total points needed
/// [playerTotal] represent player points offered to make this trade

class AdvanceTRadeButton extends StatefulWidget {
  final BehaviorSubject<int> requiredTotal;
  final BehaviorSubject<int> playerTotal;
  final Function onTap;

  const AdvanceTRadeButton({
    Key key,
    this.requiredTotal,
    this.playerTotal,
    this.onTap,
  }) : super(key: key);

  @override
  _AdvanceTRadeButtonState createState() => _AdvanceTRadeButtonState();
}

class _AdvanceTRadeButtonState extends State<AdvanceTRadeButton> {
  @override
  void initState() {
    super.initState();
    widget.playerTotal.listen(updateHandler);
    widget.requiredTotal.listen(updateHandler);
  }

  String possibleLabel = 'Trocar';
  String notPossibleLabel = 'Não vai rolar';
  String currentLabel = '';

  updateHandler(int updateValue) {
    setState(() {
      currentLabel = notPossibleLabel;
      if (checkValuesBalance) {
        currentLabel = possibleLabel;
      }
    });
  }

  ///if [true] trade user ca trade itens
  ///
  bool get checkValuesBalance {
    return widget.playerTotal.value == widget.requiredTotal.value &&
        widget.requiredTotal.value > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: checkValuesBalance ? 1.0 : 0.5,
      child: BottomSheetButton(
        label: currentLabel,
        onPressed: checkValuesBalance ? widget.onTap : null,
      ),
    );
  }
}

// This class get the total point involved in the current transaction
// ignore: must_be_immutable
class TotalPOintsIndicator extends StatefulWidget {
  final BehaviorSubject<int> total;
  final List<ItensStepper> steppers;
  final Color baseColor;

  const TotalPOintsIndicator({
    Key key,
    @required this.steppers,
    @required this.baseColor,
    @required this.total,
  }) : super(key: key);

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
          setState(() => total += e.streamTotal.value);
          widget.total.add(total);
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
