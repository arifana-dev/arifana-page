part of 'experience_bloc.dart';

sealed class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object?> get props => [];
}

class ExperienceLoadRequested extends ExperienceEvent {
  const ExperienceLoadRequested();
}
