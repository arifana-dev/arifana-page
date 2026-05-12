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
import '../../domain/experience_item.dart';
import '../bloc/experience_bloc.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExperienceBloc, ExperienceState>(
      builder: (context, state) {
        if (state is! ExperienceLoaded) return const SizedBox.shrink();
        return SectionContainer(
          background: AppColors.background,
          child: _ExperienceContent(
            experiences: state.experiences,
            education: state.education,
          ),
        );
      },
    );
  }
}

class _ExperienceContent extends StatelessWidget {
  const _ExperienceContent({
    required this.experiences,
    required this.education,
  });

  final List<ExperienceItem> experiences;
  final EducationItem education;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      label: '03 / Experience',
                      title: AppStrings.experienceTitle,
                    )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideY(begin: 0.2, end: 0),
                    const SizedBox(height: AppSpacing.xxl),
                    _Timeline(experiences: experiences),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xxl),
              Expanded(
                flex: 2,
                child: _EducationCard(education: education),
              ),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                label: '03 / Experience',
                title: AppStrings.experienceTitle,
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: AppSpacing.xxl),
              _Timeline(experiences: experiences),
              const SizedBox(height: AppSpacing.xxl),
              _EducationCard(education: education),
            ],
          ),
      ],
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.experiences});
  final List<ExperienceItem> experiences;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: experiences.asMap().entries.map((entry) {
        final isLast = entry.key == experiences.length - 1;
        return _TimelineItem(
          item: entry.value,
          isLast: isLast,
          index: entry.key,
        );
      }).toList(),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  const _TimelineItem({
    required this.item,
    required this.isLast,
    required this.index,
  });

  final ExperienceItem item;
  final bool isLast;
  final int index;

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _hover = false;

  static const double _dotSize = 14;
  static const double _railWidth = 20;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.isLast ? 0 : AppSpacing.xl),
      child: Stack(
        children: [
          if (!widget.isLast)
            Positioned(
              top: _dotSize / 2,
              bottom: -AppSpacing.xl,
              left: (_railWidth - 2) / 2,
              width: 2,
              child: Container(color: AppColors.timelineLine),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: _railWidth,
                child: Center(
                  child: Container(
                    width: _dotSize,
                    height: _dotSize,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: MouseRegion(
                  onEnter: (_) => setState(() => _hover = true),
                  onExit: (_) => setState(() => _hover = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: _hover
                          ? AppColors.surface
                          : AppColors.surface.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _hover ? AppColors.primary : AppColors.borderAlt,
                        width: 1.5,
                      ),
                    ),
                    child: _TimelineCardContent(item: widget.item),
                  ),
                )
                    .animate()
                    .fadeIn(
                      duration: 500.ms,
                      delay: Duration(milliseconds: 200 + (widget.index * 120)),
                    )
                    .slideX(begin: -0.05, end: 0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimelineCardContent extends StatelessWidget {
  const _TimelineCardContent({required this.item});
  final ExperienceItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(item.title, style: AppTextStyles.titleLarge),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                item.type,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(item.company,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 4),
        Text(item.period, style: AppTextStyles.bodySmall),
        const SizedBox(height: AppSpacing.md),
        ...item.bullets.map(
          (b) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AppColors.textMuted,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(b, style: AppTextStyles.bodySmall),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard({required this.education});
  final EducationItem education;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(AppStrings.educationTitle, style: AppTextStyles.headlineLarge)
            .animate()
            .fadeIn(duration: 500.ms, delay: 200.ms),
        const SizedBox(height: AppSpacing.xxl),
        Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderAlt, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Icon(
                      Icons.school_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      education.degree,
                      style: AppTextStyles.titleMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                education.institution,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(education.period, style: AppTextStyles.bodySmall),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 300.ms)
            .slideY(begin: 0.1, end: 0),
      ],
    );
  }
}
