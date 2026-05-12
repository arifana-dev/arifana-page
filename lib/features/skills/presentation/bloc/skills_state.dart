part of 'skills_bloc.dart';

sealed class SkillsState extends Equatable {
  const SkillsState();

  @override
  List<Object?> get props => [];
}

class SkillsInitial extends SkillsState {
  const SkillsInitial();
}

class SkillsLoaded extends SkillsState {
  const SkillsLoaded(this.categories);

  final List<SkillCategory> categories;

  @override
  List<Object?> get props => [categories];
}
