import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/url_helper.dart';

class SocialIconButton extends StatefulWidget {
  const SocialIconButton({
    required this.icon,
    required this.url,
    required this.tooltip,
    super.key,
  });

  final IconData icon;
  final String url;
  final String tooltip;

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: () => UrlHelper.open(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _hover ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _hover ? AppColors.primary : AppColors.borderAlt,
                width: 1.5,
              ),
            ),
            child: Icon(
              widget.icon,
              size: 20,
              color: _hover ? AppColors.background : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
