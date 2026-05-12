import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/hero_repository.dart';
import '../../domain/hero_info.dart';

part 'hero_event.dart';
part 'hero_state.dart';

class HeroBloc extends Bloc<HeroEvent, HeroState> {
  HeroBloc(this._repository) : super(const HeroInitial()) {
    on<HeroLoadRequested>(_onLoad);
  }

  final HeroRepository _repository;

  void _onLoad(HeroLoadRequested event, Emitter<HeroState> emit) {
    emit(HeroLoaded(_repository.getHeroInfo()));
  }
}
