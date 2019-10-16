import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CategoryEvent extends Equatable {}

class Fetch extends CategoryEvent {
  @override
  String toString() => 'Fetch categories';
}
