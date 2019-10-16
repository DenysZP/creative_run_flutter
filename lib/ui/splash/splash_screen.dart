import 'package:creative_run/bloc/category/category_bloc.dart';
import 'package:creative_run/bloc/category/category_event.dart';
import 'package:creative_run/bloc/category/category_state.dart';
import 'package:creative_run/repo/repository.dart';
import 'package:creative_run/ui/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  CategoryBloc _categoryBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_categoryBloc == null) {
      _categoryBloc = CategoryBloc(Provider.of<Repository>(context))
        ..dispatch(Fetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder(
          bloc: _categoryBloc,
          builder: (BuildContext context, CategoryState state) {
            if (state is InitialCategoryState) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed(home);
              });
            }
            return Text("Splash");
          },
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }
}
