import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/launchers.dart';

/// Fixed bottom-right quick actions: WhatsApp, Call and a scroll-to-top button
/// that fades in once the user scrolls down.
class FloatingActions extends StatelessWidget {
  const FloatingActions({
    super.key,
    required this.showToTop,
    required this.onToTop,
  });

  final bool showToTop;
  final VoidCallback onToTop;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedSlide(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            offset: showToTop ? Offset.zero : const Offset(0, 1.4),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: showToTop ? 1 : 0,
              child: _FabButton(
                tooltip: 'Back to top',
                icon: Icons.keyboard_arrow_up_rounded,
                background: AppColors.navy900,
                onTap: onToTop,
                size: 44,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _FabButton(
            tooltip: 'Call us',
            icon: Icons.call_rounded,
            background: AppColors.red600,
            onTap: Launch.phone,
          ),
          const SizedBox(height: 12),
          _FabButton(
            tooltip: 'Chat on WhatsApp',
            icon: Icons.chat,
            background: const Color(0xFF25D366),
            onTap: () => Launch.whatsApp(
              "Hello Deopel, I'd like to know more about your training programs.",
            ),
          ),
        ],
      ),
    );
  }
}

class _FabButton extends StatefulWidget {
  const _FabButton({
    required this.tooltip,
    required this.icon,
    required this.background,
    required this.onTap,
    this.size = 54,
  });

  final String tooltip;
  final IconData icon;
  final Color background;
  final VoidCallback onTap;
  final double size;

  @override
  State<_FabButton> createState() => _FabButtonState();
}

class _FabButtonState extends State<_FabButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: widget.size,
            height: widget.size,
            transform: Matrix4.translationValues(0, _hover ? -3 : 0, 0),
            decoration: BoxDecoration(
              color: widget.background,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.background.withValues(alpha: _hover ? 0.5 : 0.35),
                  blurRadius: _hover ? 22 : 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(widget.icon, color: AppColors.white, size: 24),
          ),
        ),
      ),
    );
  }
}
