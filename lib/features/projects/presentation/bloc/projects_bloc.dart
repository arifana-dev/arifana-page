import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/projects_repository.dart';
import '../../domain/project_item.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc(this._repository) : super(const ProjectsInitial()) {
    on<ProjectsLoadRequested>(_onLoad);
    on<_ProjectsUpdated>(_onUpdated);
    on<_ProjectsFailed>(_onFailed);
  }

  final ProjectsRepository _repository;
  StreamSubscription<List<ProjectItem>>? _subscription;

  Future<void> _onLoad(
    ProjectsLoadRequested event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(const ProjectsLoading());
    await _subscription?.cancel();
    _subscription = _repository.watchPublishedProjects().listen(
          (projects) => add(_ProjectsUpdated(projects)),
          onError: (Object error) => add(_ProjectsFailed(error.toString())),
        );
  }

  void _onUpdated(_ProjectsUpdated event, Emitter<ProjectsState> emit) {
    emit(ProjectsLoaded(event.projects));
  }

  void _onFailed(_ProjectsFailed event, Emitter<ProjectsState> emit) {
    emit(ProjectsFailure(event.message));
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
