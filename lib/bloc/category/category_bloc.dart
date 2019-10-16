import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:creative_run/bloc/category/category_event.dart';
import 'package:creative_run/bloc/category/category_state.dart';
import 'package:creative_run/repo/repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final Repository _repository;

  CategoryBloc(this._repository);

  @override
  CategoryState get initialState => InitialCategoryState();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    try {
      if (currentState is InitialCategoryState) {
        final categories = await _repository.getCategories();
        print(categories);
        yield DataCategoryState(categories);
        return;
      }
    } catch (error, stacktrace) {
      print(stacktrace);
      yield ErrorCategoryState();
    }
  }
}
