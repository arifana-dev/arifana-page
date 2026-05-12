import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/url_helper.dart';
import '../../../../core/widgets/section_container.dart';
import '../../domain/contact_info.dart';
import '../bloc/contact_bloc.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        if (state is! ContactLoaded) return const SizedBox.shrink();
        return SectionContainer(
          background: AppColors.surface,
          child: _ContactContent(info: state.info),
        );
      },
    );
  }
}

class _ContactContent extends StatelessWidget {
  const _ContactContent({required this.info});
  final ContactInfo info;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 24, height: 2, color: AppColors.primary),
            const SizedBox(width: 10),
            Text(
              '04 / CONTACT',
              style: AppTextStyles.sectionLabel,
            ),
            const SizedBox(width: 10),
            Container(width: 24, height: 2, color: AppColors.primary),
          ],
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppSpacing.md),
        Text(
          AppStrings.contactTitle,
          textAlign: TextAlign.center,
          style: isMobile
              ? AppTextStyles.displayMedium
              : AppTextStyles.displayLarge,
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 100.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            AppStrings.contactSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
        const SizedBox(height: AppSpacing.xl),
        _EmailButton(email: info.email)
            .animate()
            .fadeIn(duration: 500.ms, delay: 300.ms)
            .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
        const SizedBox(height: AppSpacing.xxl),
        _SocialsRow(info: info)
            .animate()
            .fadeIn(duration: 600.ms, delay: 400.ms),
        const SizedBox(height: AppSpacing.xxl),
        const Divider(color: AppColors.borderAlt, height: 1),
        const SizedBox(height: AppSpacing.lg),
        _Footer(info: info),
      ],
    );
  }
}

class _EmailButton extends StatefulWidget {
  const _EmailButton({required this.email});
  final String email;

  @override
  State<_EmailButton> createState() => _EmailButtonState();
}

class _EmailButtonState extends State<_EmailButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => UrlHelper.sendEmail(widget.email),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          decoration: BoxDecoration(
            color: _hover ? AppColors.primaryDim : AppColors.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: _hover ? 0.35 : 0.2),
                blurRadius: _hover ? 24 : 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mail_outline,
                  size: 20, color: AppColors.background),
              const SizedBox(width: 10),
              Text(
                widget.email,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.background,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialsRow extends StatelessWidget {
  const _SocialsRow({required this.info});
  final ContactInfo info;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      alignment: WrapAlignment.center,
      children: [
        _SocialCard(
          icon: Icons.code,
          label: AppStrings.contactGithub,
          sub: 'github.com/arifana-dev',
          url: info.githubUrl,
        ),
        _SocialCard(
          icon: Icons.work_outline,
          label: AppStrings.contactLinkedin,
          sub: 'linkedin.com/in/arifana',
          url: info.linkedinUrl,
        ),
        _SocialCard(
          icon: Icons.language,
          label: 'Portfolio',
          sub: 'arifana.id',
          url: info.portfolioUrl,
        ),
      ],
    );
  }
}

class _SocialCard extends StatefulWidget {
  const _SocialCard({
    required this.icon,
    required this.label,
    required this.sub,
    required this.url,
  });

  final IconData icon;
  final String label;
  final String sub;
  final String url;

  @override
  State<_SocialCard> createState() => _SocialCardState();
}

class _SocialCardState extends State<_SocialCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => UrlHelper.open(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 220,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hover ? AppColors.primary : AppColors.borderAlt,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _hover
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  widget.icon,
                  color: _hover ? AppColors.background : AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.label, style: AppTextStyles.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      widget.sub,
                      style: AppTextStyles.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.info});
  final ContactInfo info;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final left = Text(
      AppStrings.footerText,
      style: AppTextStyles.bodySmall,
      textAlign: TextAlign.center,
    );

    final right = Wrap(
      spacing: AppSpacing.md,
      children: [
        _FooterLink(
          label: AppStrings.email,
          onTap: () => UrlHelper.sendEmail(info.email),
        ),
        _FooterLink(
          label: AppStrings.phone,
          onTap: () => UrlHelper.openWhatsApp(AppStrings.phone),
        ),
      ],
    );

    if (isMobile) {
      return Column(
        children: [
          left,
          const SizedBox(height: AppSpacing.sm),
          right,
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [left, right],
    );
  }
}

class _FooterLink extends StatefulWidget {
  const _FooterLink({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTextStyles.bodySmall.copyWith(
            color: _hover ? AppColors.primary : AppColors.textSecondary,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
