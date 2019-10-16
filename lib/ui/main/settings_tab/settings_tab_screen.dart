import 'package:creative_run/generated/i18n.dart';
import 'package:flutter/material.dart';

class SettingsTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(S.of(context).settings),
      ),
    );
  }
}
