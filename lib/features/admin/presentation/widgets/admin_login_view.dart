import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/admin_auth_bloc.dart';

class AdminLoginView extends StatefulWidget {
  const AdminLoginView({super.key});

  @override
  State<AdminLoginView> createState() => _AdminLoginViewState();
}

class _AdminLoginViewState extends State<AdminLoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<AdminAuthBloc>().add(
          AdminSignInRequested(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderAlt, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Admin Login', style: AppTextStyles.headlineLarge),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Login untuk update portfolio content.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xl),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _passwordController,
                obscureText: true,
                onSubmitted: (_) => _submit(),
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: AppSpacing.xl),
              BlocBuilder<AdminAuthBloc, AdminAuthState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is AdminAuthLoading ? null : _submit,
                    child: Text(
                        state is AdminAuthLoading ? 'Logging in...' : 'Login'),
                  );
                },
              ),
              BlocBuilder<AdminAuthBloc, AdminAuthState>(
                builder: (context, state) {
                  if (state is! AdminAuthFailure) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.md),
                    child: Text(
                      state.message,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: Colors.redAccent),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
