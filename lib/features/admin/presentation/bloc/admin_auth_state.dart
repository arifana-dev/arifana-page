part of 'admin_auth_bloc.dart';

sealed class AdminAuthState extends Equatable {
  const AdminAuthState();

  @override
  List<Object?> get props => [];
}

class AdminAuthLoading extends AdminAuthState {
  const AdminAuthLoading();
}

class AdminAuthenticated extends AdminAuthState {
  const AdminAuthenticated(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class AdminUnauthenticated extends AdminAuthState {
  const AdminUnauthenticated();
}

class AdminAuthFailure extends AdminAuthState {
  const AdminAuthFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
