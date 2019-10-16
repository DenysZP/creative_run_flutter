import 'package:creative_run/bloc/projects/projects_bloc.dart';
import 'package:creative_run/generated/i18n.dart';
import 'package:creative_run/repo/repository.dart';
import 'package:creative_run/ui/main/favorites_tab/favorites_tab_screen.dart';
import 'package:creative_run/ui/main/home_tab/home_tab_screen.dart';
import 'package:creative_run/ui/main/settings_tab/settings_tab_screen.dart';
import 'package:creative_run/ui/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bloc/projects/projects_event.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  static const _HOME_TAB_INDEX = 0;
  static const _FAVORITES_TAB_INDEX = 1;
  static const _SETTINGS_TAB_INDEX = 2;

  ProjectsBloc _projectBlock;
  int _currentTabIndex = _HOME_TAB_INDEX;

  get _tabScreen {
    switch (_currentTabIndex) {
      case _HOME_TAB_INDEX:
        return HomeTabScreen(_projectBlock);
      case _FAVORITES_TAB_INDEX:
        return FavoritesTabScreen();
      case _SETTINGS_TAB_INDEX:
        return SettingsTabScreen();
      default:
        return HomeTabScreen(_projectBlock);
    }
  }

  _getTabDataList(S localizations) {
    return [
      {"icon": Icons.home, "title": localizations.home},
      {"icon": Icons.favorite, "title": localizations.favorites},
      {"icon": Icons.settings, "title": localizations.settings},
    ];
  }

  void _onTabTapped(int tabIndex) {
    setState(() {
      _currentTabIndex = tabIndex;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_projectBlock == null) {
      _projectBlock = ProjectsBloc(Provider.of<Repository>(context))
        ..dispatch(Fetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> tabDataList =
        _getTabDataList(S.of(context));
    return Scaffold(
      appBar: AppBar(
        title: Text(tabDataList[_currentTabIndex]["title"] as String),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, search);
            },
          ),
        ],
      ),
      body: _projectBlock != null ? _tabScreen : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: _onTabTapped,
        items: tabDataList.map(
          (item) {
            final iconData = item["icon"] as IconData;
            final titleText = item["title"] as String;
            return BottomNavigationBarItem(
              icon: Icon(iconData),
              title: Text(titleText),
            );
          },
        ).toList(),
      ),
    );
  }
}
