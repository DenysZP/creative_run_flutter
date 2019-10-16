import 'package:creative_run/generated/i18n.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchScreenState();
  }
}

enum _Mode { list, tune, search }

class _SearchScreenState extends State<SearchScreen> {
  var _currentMode = _Mode.list;

  get leadingIcon {
    if (_currentMode == _Mode.list) {
      return Icon(Icons.arrow_back);
    } else {
      return Icon(Icons.close);
    }
  }

  void onLeadingPressed() {
    if (_currentMode == _Mode.list) {
      Navigator.pop(context);
    } else {
      setState(() {
        _currentMode = _Mode.list;
      });
    }
  }

  void onSearchPressed() {
    setState(() {
      _currentMode = _Mode.search;
    });
  }

  void onTunePressed() {
    setState(() {
      _currentMode = _Mode.tune;
    });
  }

  void onBottomSheetClosed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: leadingIcon,
          onPressed: onLeadingPressed,
        ),
        actions: <Widget>[
          Visibility(
            visible: _currentMode == _Mode.list,
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: onSearchPressed,
            ),
          ),
          Visibility(
            visible: _currentMode != _Mode.tune,
            child: IconButton(
              icon: Icon(Icons.tune),
              onPressed: onTunePressed,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Text(S.of(context).search),
          ActionChip(
            label: Text("Category"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
