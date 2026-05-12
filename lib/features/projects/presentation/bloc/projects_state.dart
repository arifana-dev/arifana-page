part of 'projects_bloc.dart';

sealed class ProjectsState extends Equatable {
  const ProjectsState();

  @override
  List<Object?> get props => [];
}

class ProjectsInitial extends ProjectsState {
  const ProjectsInitial();
}

class ProjectsLoading extends ProjectsState {
  const ProjectsLoading();
}

class ProjectsLoaded extends ProjectsState {
  const ProjectsLoaded(this.projects);

  final List<ProjectItem> projects;

  @override
  List<Object?> get props => [projects];
}

class ProjectsFailure extends ProjectsState {
  const ProjectsFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
