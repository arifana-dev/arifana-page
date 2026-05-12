part of 'about_bloc.dart';

sealed class AboutState extends Equatable {
  const AboutState();

  @override
  List<Object?> get props => [];
}

class AboutInitial extends AboutState {
  const AboutInitial();
}

class AboutLoaded extends AboutState {
  const AboutLoaded(this.info);

  final AboutInfo info;

  @override
  List<Object?> get props => [info];
}
