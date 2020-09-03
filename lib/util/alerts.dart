import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

/// Pop an Alert box to users
///
/// Used after an api call that needs an feedback to user
/// Receives  [http StatusCode] and  [BuildContext context] to define and show the messages
///
reportInfeteddAlertSuccess(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: 'Report recebido',
    desc:
        'Em breve uma equipe do grupo S.T.A.R.S será enviada ao local, para tentar te resgatar, fique atento!',
    buttons: [
      DialogButton(
        child: Text("Beleza!",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

reportInfeteddAlertSpam(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: 'De novo isso!',
    desc:
        'Procure não forçar a barra com informações redundantes. Você pode acabar se infectando assim.',
    buttons: [
      DialogButton(
        child: Text("Entendi",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
      DialogButton(
        child: Text("Dane-se!",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
    ],
  ).show();
}

reportInfeteddAlerError(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: 'Houve um problema dwessa vez!',
    desc:
        'Pro algum motivo nossas equipes não entenderam seu pedido ou você está fora da área de cobertura da S.T.A.R.S, envia um email para eudangeld@gmail.com se achar melhor.',
    buttons: [
      DialogButton(
        child: Text("Ok", style: TextStyle(color: Colors.white, fontSize: 20)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
    ],
  ).show();
}

reportOurselfAlert(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: 'Se tá maluko?',
    desc: 'Ninguém sai por aí gritando que está infectado.',
    buttons: [
      DialogButton(
        child: Text("ENTENDI",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
    ],
  ).show();
}
