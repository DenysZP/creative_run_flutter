import 'package:equatable/equatable.dart';

abstract class ProjectsEvent extends Equatable {}

class Fetch extends ProjectsEvent {
  @override
  String toString() => 'Fetch';
}
