import 'package:creative_run/bloc/projects/projects_bloc.dart';
import 'package:creative_run/bloc/projects/projects_event.dart';
import 'package:creative_run/bloc/projects/projects_state.dart';
import 'package:creative_run/model/project.dart';
import 'package:creative_run/ui/item/project_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabScreen extends StatefulWidget {
  static const double _scrollThreshold = 200;

  final ProjectsBloc _projectBloc;

  HomeTabScreen(this._projectBloc);

  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget._projectBloc,
      builder: (BuildContext context, ProjectsState state) {
        return Container(child: _buildStateWidget(context, state));
      },
    );
  }

  Widget _buildStateWidget(BuildContext context, ProjectsState state) {
    if (state is ProjectsLoaded) {
      return _buildList(state.projects);
    } else if (state is ProjectsError) {
      return Text("ERROR");
    } else {
      return _buildLoading();
    }
  }

  Widget _buildList(List<Project> projects) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index < projects.length) {
          return ProjectListItem(projects[index]);
        }
        return null;
      },
      controller: _scrollController,
      addAutomaticKeepAlives: false,
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final isLoading = widget._projectBloc.currentState is ProjectsPaging;
    if (maxScroll - currentScroll <= HomeTabScreen._scrollThreshold &&
        !isLoading) {
      widget._projectBloc.dispatch(Fetch());
    }
  }
}
