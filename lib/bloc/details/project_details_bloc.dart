import 'package:bloc/bloc.dart';
import 'package:creative_run/bloc/details/project_details_state.dart';
import 'package:creative_run/repo/repository.dart';
import 'package:creative_run/bloc/details/project_details_event.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final Repository _repository;

  ProjectDetailsBloc(this._repository);

  @override
  ProjectDetailsState get initialState => ProjectDetailsUninitialized();

  @override
  Stream<ProjectDetailsState> mapEventToState(
      ProjectDetailsEvent event) async* {
    try {
      if (event is Fetch) {
        final projectDetails = await _repository.getProjectDetails(event.id);
        yield ProjectDetailsLoaded(projectDetails);
        return;
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      yield ProjectDetailsError();
    }
  }
}
