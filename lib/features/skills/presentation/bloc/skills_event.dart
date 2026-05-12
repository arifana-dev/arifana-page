part of 'skills_bloc.dart';

sealed class SkillsEvent extends Equatable {
  const SkillsEvent();

  @override
  List<Object?> get props => [];
}

class SkillsLoadRequested extends SkillsEvent {
  const SkillsLoadRequested();
}
