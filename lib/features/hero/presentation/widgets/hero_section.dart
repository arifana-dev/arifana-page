import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/section_keys.dart';
import '../../../../core/widgets/section_container.dart';
import '../bloc/hero_bloc.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeroBloc, HeroState>(
      builder: (context, state) {
        if (state is! HeroLoaded) return const SizedBox.shrink();
        final info = state.info;
        final isDesktop = Responsive.isDesktop(context);

        return SectionContainer(
          topPadding: AppSpacing.navHeight + AppSpacing.xxxl,
          bottomPadding: AppSpacing.section,
          child: isDesktop
              ? _DesktopLayout(info: info)
              : _MobileLayout(info: info),
        );
      },
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.info});
  final dynamic info;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 3, child: _HeroContent(info: info)),
        const SizedBox(width: AppSpacing.xxxl),
        const Expanded(flex: 2, child: _HeroAvatar()),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.info});
  final dynamic info;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroContent(info: info),
      ],
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({required this.info});
  final dynamic info;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final displayStyle =
        isMobile ? AppTextStyles.displayMedium : AppTextStyles.displayLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${info.greeting} 👋',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 100.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppSpacing.md),
        Text(info.name, style: displayStyle)
            .animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppSpacing.sm),
        _RoleText(role: info.role)
            .animate()
            .fadeIn(duration: 600.ms, delay: 300.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppSpacing.lg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(info.tagline, style: AppTextStyles.bodyLarge),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 400.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppSpacing.xl),
        const _HeroActions()
            .animate()
            .fadeIn(duration: 600.ms, delay: 500.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppSpacing.xl),
        _LocationBadge(location: info.location)
            .animate()
            .fadeIn(duration: 600.ms, delay: 600.ms),
      ],
    );
  }
}

class _RoleText extends StatelessWidget {
  const _RoleText({required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${role.split(' ').first} ',
            style: (isMobile
                    ? AppTextStyles.displayMedium
                    : AppTextStyles.displayLarge)
                .copyWith(color: AppColors.primary),
          ),
          TextSpan(
            text: role.split(' ').skip(1).join(' '),
            style: isMobile
                ? AppTextStyles.displayMedium
                : AppTextStyles.displayLarge,
          ),
        ],
      ),
    );
  }
}

class _HeroActions extends StatelessWidget {
  const _HeroActions();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final primary = ElevatedButton(
      onPressed: () => SectionKeys.scrollTo(PortfolioSection.experience),
      child: const Text(AppStrings.heroCta1),
    );
    final secondary = OutlinedButton(
      onPressed: () => SectionKeys.scrollTo(PortfolioSection.contact),
      child: const Text(AppStrings.heroCta2),
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(width: double.infinity, child: primary),
          const SizedBox(height: AppSpacing.md),
          SizedBox(width: double.infinity, child: secondary),
        ],
      );
    }
    return Row(
      children: [
        primary,
        const SizedBox(width: AppSpacing.md),
        secondary,
      ],
    );
  }
}

class _LocationBadge extends StatelessWidget {
  const _LocationBadge({required this.location});
  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.location_on_outlined,
            size: 16, color: AppColors.textMuted),
        const SizedBox(width: 6),
        Text(location, style: AppTextStyles.bodySmall),
      ],
    );
  }
}

class _HeroAvatar extends StatelessWidget {
  const _HeroAvatar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320,
        height: 320,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.surface, AppColors.surfaceAlt],
          ),
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.person, size: 120, color: AppColors.textMuted),
            Positioned(
              bottom: 24,
              right: 24,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Flutter Dev',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.background,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 800.ms, delay: 400.ms)
          .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
    );
  }
}
