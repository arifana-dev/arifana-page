import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/admin_auth_repository.dart';

part 'admin_auth_event.dart';
part 'admin_auth_state.dart';

class AdminAuthBloc extends Bloc<AdminAuthEvent, AdminAuthState> {
  AdminAuthBloc(this._repository) : super(const AdminAuthLoading()) {
    on<AdminAuthStarted>(_onStarted);
    on<_AdminAuthChanged>(_onChanged);
    on<AdminSignInRequested>(_onSignInRequested);
    on<AdminSignOutRequested>(_onSignOutRequested);
  }

  final AdminAuthRepository _repository;
  StreamSubscription<User?>? _subscription;

  Future<void> _onStarted(
    AdminAuthStarted event,
    Emitter<AdminAuthState> emit,
  ) async {
    emit(const AdminAuthLoading());
    await _subscription?.cancel();
    _subscription = _repository.authStateChanges().listen(
          (user) => add(_AdminAuthChanged(user)),
        );
  }

  void _onChanged(_AdminAuthChanged event, Emitter<AdminAuthState> emit) {
    final user = event.user;
    if (user == null) {
      emit(const AdminUnauthenticated());
    } else {
      emit(AdminAuthenticated(user.email ?? 'Admin'));
    }
  }

  Future<void> _onSignInRequested(
    AdminSignInRequested event,
    Emitter<AdminAuthState> emit,
  ) async {
    emit(const AdminAuthLoading());
    try {
      await _repository.signIn(email: event.email, password: event.password);
    } on FirebaseAuthException catch (error) {
      emit(AdminAuthFailure(error.message ?? 'Login failed.'));
      emit(const AdminUnauthenticated());
    } catch (_) {
      emit(const AdminAuthFailure('Login failed.'));
      emit(const AdminUnauthenticated());
    }
  }

  Future<void> _onSignOutRequested(
    AdminSignOutRequested event,
    Emitter<AdminAuthState> emit,
  ) async {
    await _repository.signOut();
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
