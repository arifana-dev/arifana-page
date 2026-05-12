import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/skills_repository.dart';
import '../../domain/skill_category.dart';

part 'skills_event.dart';
part 'skills_state.dart';

class SkillsBloc extends Bloc<SkillsEvent, SkillsState> {
  SkillsBloc(this._repository) : super(const SkillsInitial()) {
    on<SkillsLoadRequested>(_onLoad);
  }

  final SkillsRepository _repository;

  void _onLoad(SkillsLoadRequested event, Emitter<SkillsState> emit) {
    emit(SkillsLoaded(_repository.getSkills()));
  }
}
