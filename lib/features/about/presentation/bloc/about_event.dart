part of 'about_bloc.dart';

sealed class AboutEvent extends Equatable {
  const AboutEvent();

  @override
  List<Object?> get props => [];
}

class AboutLoadRequested extends AboutEvent {
  const AboutLoadRequested();
}
