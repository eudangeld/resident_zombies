import 'package:flutter/material.dart';
import 'package:resident_zombies/pages/main_game_page.dart';
import 'package:resident_zombies/theme/global_theme.dart';
import 'package:resident_zombies/widgets/bottom_sheet_button.dart';

///Page to show trade result
///callled after trade alert confirm
///result is passed by aroute arguments
///

class TradeResultPage extends StatelessWidget {
  static String get routeName => '@routes/trade_result_page';

  @override
  Widget build(BuildContext context) {
    final dynamic _routeArgs = ModalRoute.of(context).settings.arguments;
    return _routeArgs.statusCode > 204 ? TradeFail() : TradeSuccess();
  }
}

class TradeFail extends StatelessWidget {
  final String _failAssetPath = 'assets/trade_fail.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Falha na transação'),
      ),
      bottomSheet: BottomSheetButton(
        label: 'Voltar',
        onPressed: () => Navigator.of(context)
            .popUntil((route) => route.settings.name == MainGamePage.routeName),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * .20),
                child: Image.asset(_failAssetPath)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Não foi possível concluir esta transação',
                style: TextStyle(
                    fontSize: 20,
                    color: heavyDark,
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichText(
                text: TextSpan(
                    text: 'Verifique a ',
                    style: TextStyle(fontSize: 16, color: heavyDark),
                    children: [
                  TextSpan(
                      text: 'distância física',
                      style: TextStyle(
                          fontSize: 16,
                          color: heavyDark,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          ' entre você e o trader, isso faz bastante diferença.',
                      style: TextStyle(fontSize: 16, color: heavyDark)),
                  TextSpan(
                      text:
                          ' \nVerifique também se você possui os pontos necessários para fazer essa transação.',
                      style: TextStyle(fontSize: 16, color: heavyDark)),
                ])),
          ),
        ],
      ),
    );
  }
}

class TradeSuccess extends StatelessWidget {
  final String _successAssetPath = 'assets/trade_success.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tudo certo'),
      ),
      bottomSheet: BottomSheetButton(
        label: 'Voltar',
        onPressed: () => Navigator.of(context)
            .popUntil((route) => route.settings.name == MainGamePage.routeName),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * .20),
                child: Image.asset(_successAssetPath)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Deu tudo certo com a troca',
                style: TextStyle(
                    fontSize: 20,
                    color: heavyDark,
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichText(
                text: TextSpan(
                    text: 'Verifique os ítens no menu ',
                    style: TextStyle(fontSize: 16, color: heavyDark),
                    children: [
                  TextSpan(
                      text: 'meus ítens',
                      style: TextStyle(
                          fontSize: 16,
                          color: heavyDark,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          ' continue fazendo trocas, elas são fundamentais para sua sobrevicência',
                      style: TextStyle(fontSize: 16, color: heavyDark)),
                ])),
          ),
        ],
      ),
    );
  }
}
