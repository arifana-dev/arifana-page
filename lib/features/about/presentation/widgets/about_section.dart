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
import '../../domain/about_info.dart';
import '../bloc/about_bloc.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutBloc, AboutState>(
      builder: (context, state) {
        if (state is! AboutLoaded) return const SizedBox.shrink();
        return SectionContainer(
          background: AppColors.background,
          child: _AboutContent(info: state.info),
        );
      },
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent({required this.info});

  final AboutInfo info;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(label: '01 / About', title: AppStrings.aboutTitle)
            .animate()
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppSpacing.xxl),
        if (isDesktop)
          _DesktopLayout(info: info)
        else
          _MobileLayout(info: info),
      ],
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.info});
  final AboutInfo info;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _PhotoPlaceholder()),
        const SizedBox(width: AppSpacing.xxl),
        Expanded(flex: 3, child: _AboutText(info: info)),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.info});
  final AboutInfo info;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PhotoPlaceholder(),
        const SizedBox(height: AppSpacing.xl),
        _AboutText(info: info),
      ],
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 380),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderAlt, width: 1),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _GridPainter()),
            ),
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: const Icon(
                  Icons.person_outline,
                  size: 56,
                  color: AppColors.primary,
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'ARIFANA.DEV',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.background,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.15,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 600.ms)
          .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.borderAlt.withValues(alpha: 0.4)
      ..strokeWidth = 1;
    const step = 24.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AboutText extends StatelessWidget {
  const _AboutText({required this.info});
  final AboutInfo info;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(info.bio, style: AppTextStyles.bodyLarge)
            .animate()
            .fadeIn(duration: 600.ms, delay: 150.ms)
            .slideY(begin: 0.1, end: 0),
        const SizedBox(height: AppSpacing.xl),
        ...info.highlights.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _HighlightRow(text: e.value)
                    .animate()
                    .fadeIn(
                      duration: 400.ms,
                      delay: Duration(milliseconds: 250 + (e.key * 80)),
                    )
                    .slideX(begin: -0.05, end: 0),
              ),
            ),
        const SizedBox(height: AppSpacing.xl),
        _LanguagesRow(languages: info.languages)
            .animate()
            .fadeIn(duration: 500.ms, delay: 600.ms),
      ],
    );
  }
}

class _HighlightRow extends StatelessWidget {
  const _HighlightRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _LanguagesRow extends StatelessWidget {
  const _LanguagesRow({required this.languages});
  final List<LanguageProficiency> languages;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.lg,
      runSpacing: AppSpacing.sm,
      children: languages
          .map(
            (l) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.language, size: 16, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(
                  '${l.name} · ',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  l.level,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
