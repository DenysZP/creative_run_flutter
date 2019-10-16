import 'package:equatable/equatable.dart';

abstract class ProjectDetailsEvent extends Equatable {}

class Fetch extends ProjectDetailsEvent {
  final int id;

  Fetch(this.id);

  @override
  String toString() => 'Fetch project by id = $id';
}
