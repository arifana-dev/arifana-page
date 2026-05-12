import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../projects/domain/project_item.dart';
import '../../data/admin_projects_repository.dart';
import '../bloc/admin_auth_bloc.dart';
import 'project_form_dialog.dart';

class AdminProjectsView extends StatelessWidget {
  const AdminProjectsView({required this.email, super.key});

  final String email;

  Future<void> _openForm(BuildContext context, [ProjectItem? project]) async {
    final repository = context.read<AdminProjectsRepository>();
    final result = await showDialog<ProjectItem>(
      context: context,
      builder: (_) => ProjectFormDialog(project: project),
    );
    if (result == null) return;
    if (project == null) {
      await repository.createProject(result);
    } else {
      await repository.updateProject(result);
    }
  }

  Future<void> _delete(BuildContext context, ProjectItem project) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete project?'),
        content: Text('Delete ${project.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await context.read<AdminProjectsRepository>().deleteProject(project.id);
  }

  Future<void> _togglePublished(
      BuildContext context, ProjectItem project) async {
    await context
        .read<AdminProjectsRepository>()
        .updateProject(project.copyWith(isPublished: !project.isPublished));
  }

  @override
  Widget build(BuildContext context) {
    final repository = context.read<AdminProjectsRepository>();

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Portfolio Admin', style: AppTextStyles.headlineLarge),
                    const SizedBox(height: 4),
                    Text(email, style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () => context.read<AdminAuthBloc>().add(
                      const AdminSignOutRequested(),
                    ),
                child: const Text('Logout'),
              ),
              const SizedBox(width: AppSpacing.md),
              ElevatedButton(
                onPressed: () => _openForm(context),
                child: const Text('Add Project'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Expanded(
            child: StreamBuilder<List<ProjectItem>>(
              stream: repository.watchProjects(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Failed to load projects.',
                      style: AppTextStyles.bodyMedium,
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                final projects = snapshot.data!;
                if (projects.isEmpty) {
                  return Center(
                    child: Text('No projects yet.',
                        style: AppTextStyles.bodyMedium),
                  );
                }
                return ListView.separated(
                  itemCount: projects.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return _ProjectAdminCard(
                      project: project,
                      onEdit: () => _openForm(context, project),
                      onDelete: () => _delete(context, project),
                      onTogglePublished: () =>
                          _togglePublished(context, project),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectAdminCard extends StatelessWidget {
  const _ProjectAdminCard({
    required this.project,
    required this.onEdit,
    required this.onDelete,
    required this.onTogglePublished,
  });

  final ProjectItem project;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTogglePublished;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderAlt, width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(project.title,
                            style: AppTextStyles.titleLarge)),
                    _StatusChip(published: project.isPublished),
                  ],
                ),
                const SizedBox(height: 6),
                Text(project.role,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.primary)),
                const SizedBox(height: 4),
                Text(project.description, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          IconButton(
            tooltip: project.isPublished ? 'Unpublish' : 'Publish',
            onPressed: onTogglePublished,
            icon: Icon(
                project.isPublished ? Icons.visibility_off : Icons.visibility),
          ),
          IconButton(
            tooltip: 'Edit',
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Delete',
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.published});

  final bool published;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: published
            ? AppColors.primary.withValues(alpha: 0.12)
            : AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        published ? 'Published' : 'Draft',
        style: AppTextStyles.labelMedium.copyWith(
          color: published ? AppColors.primary : AppColors.textSecondary,
        ),
      ),
    );
  }
}
