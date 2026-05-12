part of 'projects_bloc.dart';

sealed class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object?> get props => [];
}

class ProjectsLoadRequested extends ProjectsEvent {
  const ProjectsLoadRequested();
}

class _ProjectsUpdated extends ProjectsEvent {
  const _ProjectsUpdated(this.projects);

  final List<ProjectItem> projects;

  @override
  List<Object?> get props => [projects];
}

class _ProjectsFailed extends ProjectsEvent {
  const _ProjectsFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
