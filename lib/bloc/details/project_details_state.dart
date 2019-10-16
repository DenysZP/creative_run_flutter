import 'package:creative_run/model/project_details.dart';
import 'package:equatable/equatable.dart';

abstract class ProjectDetailsState extends Equatable {
  ProjectDetailsState([List props = const []]) : super(props);
}

class ProjectDetailsUninitialized extends ProjectDetailsState {
  @override
  String toString() => "ProjectDetailsUninitialized";
}

class ProjectDetailsLoaded extends ProjectDetailsState {
  final ProjectDetails projectDetails;

  ProjectDetailsLoaded(this.projectDetails) : super([projectDetails]);

  @override
  String toString() => "ProjectDetailsLoaded { project details }";
}

class ProjectDetailsError extends ProjectDetailsState {
  @override
  String toString() => "ProjectDetailsError";
}
