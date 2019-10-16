import 'package:creative_run/model/category.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CategoryState extends Equatable {
  CategoryState([List props = const []]) : super(props);
}

class InitialCategoryState extends CategoryState {
  @override
  String toString() => "InitialCategoryState";
}

class DataCategoryState extends CategoryState {
  final List<Category> categories;

  DataCategoryState(this.categories) : super([categories]);

  @override
  String toString() => "DataCategoryState { categories: ${categories.length} }";
}

class ErrorCategoryState extends CategoryState {
  @override
  String toString() => "ErrorCategoryState";
}
