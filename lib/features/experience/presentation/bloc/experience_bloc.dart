import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/experience_repository.dart';
import '../../domain/experience_item.dart';

part 'experience_event.dart';
part 'experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  ExperienceBloc(this._repository) : super(const ExperienceInitial()) {
    on<ExperienceLoadRequested>(_onLoad);
  }

  final ExperienceRepository _repository;

  void _onLoad(ExperienceLoadRequested event, Emitter<ExperienceState> emit) {
    emit(
      ExperienceLoaded(
        experiences: _repository.getExperiences(),
        education: _repository.getEducation(),
      ),
    );
  }
}
