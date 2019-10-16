import 'package:creative_run/model/stats.dart';
import 'package:creative_run/ui/constants.dart';
import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  static const double _imageSize = 20;
  static const double _contentSpace = 2;
  final Stats _stats;

  StatsWidget(this._stats);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildSubStats(context, Icons.visibility, _stats.views),
        _buildSubStats(context, Icons.star, _stats.appreciations),
        _buildSubStats(context, Icons.comment, _stats.comments),
      ],
    );
  }

  Widget _buildSubStats(BuildContext context, IconData iconData, int stat) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: smallSpace,
        ),
        Icon(
          iconData,
          size: _imageSize,
        ),
        SizedBox(
          width: _contentSpace,
        ),
        Text(
          stat.toString(),
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}
