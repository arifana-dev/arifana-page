import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import '../constants/app_strings.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive.dart';
import '../utils/section_keys.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final hPad = Responsive.value<double>(
      context,
      mobile: AppSpacing.mobileHPad,
      tablet: AppSpacing.tabletHPad,
      desktop: AppSpacing.desktopHPad,
    );

    return ClipRect(
      child: Container(
        height: AppSpacing.navHeight,
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.85),
          border: const Border(
            bottom: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: hPad),
        child: Row(
          children: [
            _Logo(onTap: () => SectionKeys.scrollTo(PortfolioSection.hero)),
            const Spacer(),
            if (!isMobile) const _DesktopNavLinks() else const _MobileMenu(),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
              'arifana.dev',
              style: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopNavLinks extends StatelessWidget {
  const _DesktopNavLinks();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NavLink(
          label: AppStrings.navAbout,
          onTap: () => SectionKeys.scrollTo(PortfolioSection.about),
        ),
        _NavLink(
          label: AppStrings.navSkills,
          onTap: () => SectionKeys.scrollTo(PortfolioSection.skills),
        ),
        _NavLink(
          label: AppStrings.navExperience,
          onTap: () => SectionKeys.scrollTo(PortfolioSection.experience),
        ),
        _NavLink(
          label: AppStrings.navProjects,
          onTap: () => SectionKeys.scrollTo(PortfolioSection.projects),
        ),
        const SizedBox(width: 12),
        _CtaNavButton(
          label: AppStrings.navContact,
          onTap: () => SectionKeys.scrollTo(PortfolioSection.contact),
        ),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: AppTextStyles.labelLarge.copyWith(
              color: _hover ? AppColors.primary : AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _CtaNavButton extends StatefulWidget {
  const _CtaNavButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_CtaNavButton> createState() => _CtaNavButtonState();
}

class _CtaNavButtonState extends State<_CtaNavButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: _hover ? AppColors.primary : Colors.transparent,
            border: Border.all(color: AppColors.primary, width: 1.5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.labelLarge.copyWith(
              color: _hover ? AppColors.background : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  const _MobileMenu();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PortfolioSection>(
      color: AppColors.surface,
      icon: const Icon(Icons.menu, color: AppColors.textPrimary),
      tooltip: 'Menu',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.borderAlt),
      ),
      onSelected: SectionKeys.scrollTo,
      itemBuilder: (_) => [
        _item(PortfolioSection.about, AppStrings.navAbout),
        _item(PortfolioSection.skills, AppStrings.navSkills),
        _item(PortfolioSection.experience, AppStrings.navExperience),
        _item(PortfolioSection.projects, AppStrings.navProjects),
        _item(PortfolioSection.contact, AppStrings.navContact),
      ],
    );
  }

  PopupMenuItem<PortfolioSection> _item(PortfolioSection s, String label) {
    return PopupMenuItem<PortfolioSection>(
      value: s,
      child: Text(label, style: AppTextStyles.titleMedium),
    );
  }
}
