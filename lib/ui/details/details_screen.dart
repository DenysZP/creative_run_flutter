import 'package:creative_run/bloc/details/project_details_state.dart';
import 'package:creative_run/generated/i18n.dart';
import 'package:creative_run/model/project.dart';
import 'package:creative_run/repo/repository.dart';
import 'package:creative_run/ui/constants.dart';
import 'package:creative_run/bloc/details/project_details_bloc.dart';
import 'package:creative_run/ui/widget/color_chip.dart';
import 'package:creative_run/ui/widget/stats_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../bloc/details/project_details_event.dart';

class DetailsScreen extends StatefulWidget {
  static const double imageSize = 100;

  final Project _project;

  DetailsScreen(this._project);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ProjectDetailsBloc _projectDetailsBlock;
  S _localization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_projectDetailsBlock == null) {
      _projectDetailsBlock =
          ProjectDetailsBloc(Provider.of<Repository>(context))
            ..dispatch(Fetch(widget._project.id));
    }
    if (_localization == null) {
      _localization = S.of(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).details),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => Share.share(widget._project.url),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: "image${widget._project.id}",
                  child: SizedBox(
                    width: DetailsScreen.imageSize,
                    height: DetailsScreen.imageSize,
                    child: Card(
                      color: widget._project.color,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: FadeInImage.memoryNetwork(
                        image: widget._project.thumbnailUrl,
                        placeholder: kTransparentImage,
                        width: DetailsScreen.imageSize,
                        height: DetailsScreen.imageSize,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(middleSpace),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            widget._project.title,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: smallSpace,
                            children: <Widget>[
                              ...widget._project.categories.map((category) {
                                return Chip(
                                  label: Text(category),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        StatsWidget(widget._project.stats),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder(
            bloc: _projectDetailsBlock,
            builder: (BuildContext context, ProjectDetailsState state) {
              if (state is ProjectDetailsLoaded) {
                return Column(
                  children: <Widget>[
                    ..._buildDescriptionGroup(state.projectDetails.description),
                    ..._buildColorGroup(state.projectDetails.color)
                  ],
                );
              }
              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }

  List<Widget> _buildDescriptionGroup(String description) {
    return description.isEmpty
        ? []
        : [
            Text(_localization.description),
            Text(description),
            Divider(),
          ];
  }

  List<Widget> _buildColorGroup(Color color) {
    return color.opacity == 0
        ? []
        : [
            Text(_localization.primaryColor),
            ColorChip(color),
          ];
  }
}
