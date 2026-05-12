import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/project_item.dart';
import '../bloc/projects_bloc.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        return SectionContainer(
          background: AppColors.surface,
          child: switch (state) {
            ProjectsLoaded(:final projects) =>
              _ProjectsContent(projects: projects),
            ProjectsFailure() => const _ProjectsMessage(
                title: 'Portfolio unavailable',
                message: 'Please try again later.',
              ),
            _ => const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
          },
        );
      },
    );
  }
}

class _ProjectsContent extends StatelessWidget {
  const _ProjectsContent({required this.projects});

  final List<ProjectItem> projects;

  @override
  Widget build(BuildContext context) {
    final crossCount = Responsive.value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );

    if (projects.isEmpty) {
      return const _ProjectsMessage(
        title: AppStrings.projectsTitle,
        message: 'Projects will be available soon.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          label: '04 / Portfolio',
          title: AppStrings.projectsTitle,
          subtitle:
              'Selected mobile apps and product work I have built with Flutter.',
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppSpacing.xxl),
        LayoutBuilder(
          builder: (context, constraints) {
            const gap = AppSpacing.lg;
            final itemWidth =
                (constraints.maxWidth - (gap * (crossCount - 1))) / crossCount;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: projects.asMap().entries.map((entry) {
                final index = entry.key;
                return SizedBox(
                  width: itemWidth,
                  child: _ProjectCard(project: entry.value)
                      .animate()
                      .fadeIn(
                        duration: 500.ms,
                        delay: Duration(milliseconds: 150 + (index * 100)),
                      )
                      .slideY(begin: 0.12, end: 0),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _ProjectsMessage extends StatelessWidget {
  const _ProjectsMessage({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          label: '04 / Portfolio',
          title: title,
          subtitle: message,
        ),
      ],
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project});

  final ProjectItem project;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: _hover
              ? AppColors.background
              : AppColors.background.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hover ? AppColors.primary : AppColors.borderAlt,
            width: 1.5,
          ),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.28),
                    ),
                  ),
                  child: const Icon(
                    Icons.phone_iphone_outlined,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(project.period, style: AppTextStyles.bodySmall),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(project.title, style: AppTextStyles.titleLarge),
            const SizedBox(height: 6),
            Text(
              project.role,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(project.description, style: AppTextStyles.bodySmall),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children:
                  project.tags.map((tag) => _ProjectTag(label: tag)).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
            ...project.highlights.map(
              (highlight) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(highlight, style: AppTextStyles.bodySmall),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectTag extends StatelessWidget {
  const _ProjectTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderAlt),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
