import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/admin_auth_repository.dart';
import '../../data/admin_projects_repository.dart';
import '../bloc/admin_auth_bloc.dart';
import 'admin_login_view.dart';
import 'admin_projects_view.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AdminAuthRepository>(
          create: (_) => AdminAuthRepositoryImpl(),
        ),
        RepositoryProvider<AdminProjectsRepository>(
          create: (_) => AdminProjectsRepositoryImpl(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AdminAuthBloc(
          context.read<AdminAuthRepository>(),
        )..add(const AdminAuthStarted()),
        child: const _AdminView(),
      ),
    );
  }
}

class _AdminView extends StatelessWidget {
  const _AdminView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<AdminAuthBloc, AdminAuthState>(
          builder: (context, state) {
            return switch (state) {
              AdminAuthenticated(:final email) =>
                AdminProjectsView(email: email),
              AdminUnauthenticated() || AdminAuthFailure() => const Padding(
                  padding: EdgeInsets.all(24),
                  child: AdminLoginView(),
                ),
              _ => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
            };
          },
        ),
      ),
    );
  }
}
