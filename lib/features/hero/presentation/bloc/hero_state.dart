part of 'hero_bloc.dart';

sealed class HeroState extends Equatable {
  const HeroState();

  @override
  List<Object?> get props => [];
}

class HeroInitial extends HeroState {
  const HeroInitial();
}

class HeroLoaded extends HeroState {
  const HeroLoaded(this.info);

  final HeroInfo info;

  @override
  List<Object?> get props => [info];
}
