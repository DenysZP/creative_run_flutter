import 'package:creative_run/generated/i18n.dart';
import 'package:flutter/material.dart';

class FavoritesTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(S.of(context).favorites),
            Switch.adaptive(value: true, onChanged: null),
            MaterialButton(
              child: Text("DICH"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
