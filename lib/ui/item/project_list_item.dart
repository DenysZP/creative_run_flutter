import 'package:creative_run/model/project.dart';
import 'package:creative_run/ui/constants.dart';
import 'package:creative_run/ui/router/router.dart';
import 'package:creative_run/ui/widget/stats_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProjectListItem extends StatelessWidget {
  final Project _project;

  static const double imageSize = 100;
  static const double contentMargin = 60;
  static const double contentLeftPadding = 48;

  ProjectListItem(this._project);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: smallSpace, horizontal: middleSpace),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, details, arguments: _project),
        child: Stack(
          children: <Widget>[
            Card(
              margin: EdgeInsets.only(
                left: contentMargin,
                top: middleSpace,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: contentLeftPadding,
                    top: middleSpace,
                    right: middleSpace,
                    bottom: middleSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      _project.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Wrap(
                      spacing: smallSpace,
                      children: <Widget>[
                        ..._project.categories.map((category) {
                          return Chip(
                            label: Text(category),
                          );
                        }).toList(),
                      ],
                    ),
                    StatsWidget(_project.stats),
                  ],
                ),
              ),
            ),
            Hero(
              tag: "image${_project.id}",
              child: SizedBox(
                width: imageSize,
                height: imageSize,
                child: Card(
                  color: _project.color,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: FadeInImage.memoryNetwork(
                    image: _project.thumbnailUrl,
                    placeholder: kTransparentImage,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
