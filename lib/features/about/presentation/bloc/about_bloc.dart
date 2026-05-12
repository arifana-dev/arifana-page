import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/about_repository.dart';
import '../../domain/about_info.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc(this._repository) : super(const AboutInitial()) {
    on<AboutLoadRequested>(_onLoad);
  }

  final AboutRepository _repository;

  void _onLoad(AboutLoadRequested event, Emitter<AboutState> emit) {
    emit(AboutLoaded(_repository.getAboutInfo()));
  }
}
