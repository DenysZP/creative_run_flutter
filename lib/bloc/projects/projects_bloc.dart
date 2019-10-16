import 'package:bloc/bloc.dart';
import 'package:creative_run/repo/repository.dart';
import 'package:creative_run/bloc/projects/projects_event.dart';
import 'package:creative_run/bloc/projects/projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  static const _initialPage = 1;
  static const _perPage = 20;

  final Repository _repository;

  ProjectsBloc(this._repository);

  @override
  ProjectsState get initialState => ProjectsUninitialized();

  @override
  Stream<ProjectsState> mapEventToState(ProjectsEvent event) async* {
    try {
      if (currentState is ProjectsUninitialized) {
        final projects =
            await _repository.getProjects(_initialPage, _perPage);
        yield ProjectsLoaded(projects);
        return;
      }
      if (currentState is ProjectsLoaded) {
        final previousProjects = (currentState as ProjectsLoaded).projects;
        final length = previousProjects.length;
        final page = length / _perPage + _initialPage;
        yield ProjectsPaging(previousProjects);
        final projects =
            await _repository.getProjects(page.toInt(), _perPage);
        yield ProjectsLoaded(previousProjects + projects);
      }
    } catch (error, stacktrace) {
      print(stacktrace);
      yield ProjectsError();
    }
  }
}
