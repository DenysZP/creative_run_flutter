import 'package:creative_run/ui/constants.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  final List<String> _categories;

  CategoriesWidget(this._categories);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: smallSpace,
      children: <Widget>[
        ..._categories.map((category) {
          return Chip(
            label: Text(category),
          );
        }).toList(),
      ],
    );
  }
}
