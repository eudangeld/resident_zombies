import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:resident_zombies/util/helper.dart';

import 'loading_widget.dart';

class HealthBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api(context).getHealth(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  LinearPercentIndicator(
                      width: 100.0,
                      lineHeight: 8.0,
                      percent: 0.2,
                      progressColor: Colors.red),
                ],
              ));
        }
        return Loading();
      },
    );
  }
}
