import 'package:creative_run/model/project.dart';
import 'package:equatable/equatable.dart';

abstract class ProjectsState extends Equatable {
  ProjectsState([List props = const []]) : super(props);
}

class ProjectsUninitialized extends ProjectsState {
  @override
  String toString() => "ProjectsUninitialized";
}

class ProjectsLoaded extends ProjectsState {
  final List<Project> projects;

  ProjectsLoaded(this.projects) : super([projects]);

  @override
  String toString() => "ProjectsLoaded { projects: ${projects.length} }";
}

class ProjectsPaging extends ProjectsLoaded {
  final List<Project> projects;

  ProjectsPaging(this.projects) : super(projects);

  @override
  String toString() => "ProjectsPaging { projects: ${projects.length} }";
}

class ProjectsError extends ProjectsState {
  @override
  String toString() => "ProjectsError";
}
