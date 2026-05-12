part of 'hero_bloc.dart';

sealed class HeroEvent extends Equatable {
  const HeroEvent();

  @override
  List<Object?> get props => [];
}

class HeroLoadRequested extends HeroEvent {
  const HeroLoadRequested();
}
