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
import '../../domain/skill_category.dart';
import '../bloc/skills_bloc.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkillsBloc, SkillsState>(
      builder: (context, state) {
        if (state is! SkillsLoaded) return const SizedBox.shrink();
        return SectionContainer(
          background: AppColors.surface,
          child: _SkillsContent(categories: state.categories),
        );
      },
    );
  }
}

class _SkillsContent extends StatelessWidget {
  const _SkillsContent({required this.categories});
  final List<SkillCategory> categories;

  @override
  Widget build(BuildContext context) {
    final crossCount = Responsive.value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 2,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          label: '02 / Skills',
          title: AppStrings.skillsTitle,
          subtitle:
              'Technologies and tools I use to build production-ready mobile applications.',
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
              children: categories.asMap().entries.map((entry) {
                final index = entry.key;
                return SizedBox(
                  width: itemWidth,
                  child: _SkillCategoryCard(category: entry.value)
                      .animate()
                      .fadeIn(
                        duration: 500.ms,
                        delay: Duration(milliseconds: 150 + (index * 80)),
                      )
                      .slideY(begin: 0.15, end: 0),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  const _SkillCategoryCard({required this.category});
  final SkillCategory category;

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hover ? AppColors.primary : AppColors.borderAlt,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.category.name,
                    style: AppTextStyles.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: widget.category.skills
                  .map((s) => _SkillChip(label: s))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  const _SkillChip({required this.label});
  final String label;

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: _hover
              ? AppColors.primary
              : AppColors.surfaceAlt.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: _hover ? AppColors.primary : AppColors.borderAlt,
            width: 1,
          ),
        ),
        child: Text(
          widget.label,
          style: AppTextStyles.labelLarge.copyWith(
            color: _hover ? AppColors.background : AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
