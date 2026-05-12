part of 'experience_bloc.dart';

sealed class ExperienceState extends Equatable {
  const ExperienceState();

  @override
  List<Object?> get props => [];
}

class ExperienceInitial extends ExperienceState {
  const ExperienceInitial();
}

class ExperienceLoaded extends ExperienceState {
  const ExperienceLoaded({required this.experiences, required this.education});

  final List<ExperienceItem> experiences;
  final EducationItem education;

  @override
  List<Object?> get props => [experiences, education];
}
