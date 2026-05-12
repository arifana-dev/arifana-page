part of 'admin_auth_bloc.dart';

sealed class AdminAuthEvent extends Equatable {
  const AdminAuthEvent();

  @override
  List<Object?> get props => [];
}

class AdminAuthStarted extends AdminAuthEvent {
  const AdminAuthStarted();
}

class _AdminAuthChanged extends AdminAuthEvent {
  const _AdminAuthChanged(this.user);

  final User? user;

  @override
  List<Object?> get props => [user];
}

class AdminSignInRequested extends AdminAuthEvent {
  const AdminSignInRequested({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class AdminSignOutRequested extends AdminAuthEvent {
  const AdminSignOutRequested();
}
