import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';

/// Constrains content to the site's max width with responsive horizontal
/// padding — the Flutter equivalent of the `.container` class.
class ContentContainer extends StatelessWidget {
  const ContentContainer({super.key, required this.child, this.padding});
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final horizontal = AppSizing.isMobile(context) ? 20.0 : 32.0;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSizing.maxContentWidth),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: horizontal),
          child: child,
        ),
      ),
    );
  }
}

/// The small red-underlined uppercase label used above section titles.
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.color = AppColors.red600});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 2,
          margin: const EdgeInsets.only(right: 10),
          color: color,
        ),
        Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: color,
          ),
        ),
      ],
    );
  }
}

/// Eyebrow + heading + optional lede, centered or left aligned.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.lede,
    this.center = true,
    this.onDark = false,
  });

  final String eyebrow;
  final String title;
  final String? lede;
  final bool center;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final align = center ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = center ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: align,
      children: [
        Align(
          alignment: center ? Alignment.center : Alignment.centerLeft,
          child: Eyebrow(eyebrow),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Text(
            title,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 32,
                  color: onDark ? AppColors.white : AppColors.navy900,
                ),
          ),
        ),
        if (lede != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              lede!,
              textAlign: textAlign,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: onDark ? Colors.white70 : AppColors.slate500,
                  ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Pill-shaped call-to-action button matching `.btn-primary` / `.btn-dark`.
class BrandButton extends StatefulWidget {
  const BrandButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = BrandButtonVariant.primary,
    this.icon,
    this.showArrow = true,
  });

  final String label;
  final VoidCallback onPressed;
  final BrandButtonVariant variant;
  final IconData? icon;
  final bool showArrow;

  @override
  State<BrandButton> createState() => _BrandButtonState();
}

enum BrandButtonVariant { primary, dark, outline, light }

class _BrandButtonState extends State<BrandButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    late Color bg;
    late Color fg;
    Border? border;

    switch (widget.variant) {
      case BrandButtonVariant.primary:
        bg = _hover ? AppColors.red700 : AppColors.red600;
        fg = AppColors.white;
        break;
      case BrandButtonVariant.dark:
        bg = _hover ? AppColors.navy800 : AppColors.navy900;
        fg = AppColors.white;
        break;
      case BrandButtonVariant.outline:
        bg = _hover ? Colors.white24 : Colors.transparent;
        fg = AppColors.white;
        border = Border.all(color: Colors.white54, width: 1.5);
        break;
      case BrandButtonVariant.light:
        bg = AppColors.white;
        fg = AppColors.red600;
        break;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hover ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
          decoration: BoxDecoration(
            color: bg,
            border: border,
            borderRadius: BorderRadius.circular(999),
            boxShadow: widget.variant == BrandButtonVariant.primary
                ? [
                    BoxShadow(
                      color: AppColors.red600.withValues(alpha: 0.45),
                      blurRadius: _hover ? 26 : 18,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: fg),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              if (widget.showArrow) ...[
                const SizedBox(width: 10),
                AnimatedSlide(
                  duration: const Duration(milliseconds: 200),
                  offset: Offset(_hover ? 0.25 : 0, 0),
                  child: Icon(Icons.arrow_forward, size: 18, color: fg),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Fades + slides its child in the first time it scrolls into view.
class Reveal extends StatefulWidget {
  const Reveal({super.key, required this.child, this.delayMs = 0});
  final Widget child;
  final int delayMs;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  final Key _detectorKey = UniqueKey();
  bool _shown = false;

  @override
  void initState() {
    super.initState();
    // Safety net: reveal anyway if visibility never reports (e.g. tests).
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted && !_shown) setState(() => _shown = true);
    });
  }

  void _onVisibility(VisibilityInfo info) {
    if (_shown || info.visibleFraction < 0.08) return;
    if (widget.delayMs > 0) {
      Future.delayed(Duration(milliseconds: widget.delayMs), () {
        if (mounted && !_shown) setState(() => _shown = true);
      });
    } else if (mounted) {
      setState(() => _shown = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: _onVisibility,
      child: AnimatedOpacity(
        opacity: _shown ? 1 : 0,
        duration: const Duration(milliseconds: 620),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _shown ? Offset.zero : const Offset(0, 0.14),
          duration: const Duration(milliseconds: 620),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Animates an integer up from zero to the number embedded in [value] (e.g.
/// "500+", "90%", "12+") the first time it scrolls into view. Any non-digit
/// prefix/suffix (like "+", "%") is preserved.
class CountUp extends StatefulWidget {
  const CountUp(
    this.value, {
    super.key,
    this.style,
    this.duration = const Duration(milliseconds: 1600),
  });

  final String value;
  final TextStyle? style;
  final Duration duration;

  @override
  State<CountUp> createState() => _CountUpState();
}

class _CountUpState extends State<CountUp>
    with SingleTickerProviderStateMixin {
  final Key _detectorKey = UniqueKey();
  late final int _target;
  late final String _prefix;
  late final String _suffix;
  late final AnimationController _controller;
  late final Animation<double> _anim;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    final match =
        RegExp(r'^(\D*)(\d+)(.*)$').firstMatch(widget.value.trim());
    _prefix = match?.group(1) ?? '';
    _target = int.tryParse(match?.group(2) ?? '0') ?? 0;
    _suffix = match?.group(3) ?? '';
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    // Safety net if visibility never reports.
    Future.delayed(const Duration(milliseconds: 1500), _startIfNeeded);
  }

  void _startIfNeeded() {
    if (!_started && mounted) {
      _started = true;
      _controller.forward();
    }
  }

  void _onVisibility(VisibilityInfo info) {
    if (!_started && info.visibleFraction > 0.15) _startIfNeeded();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: _onVisibility,
      child: AnimatedBuilder(
        animation: _anim,
        builder: (context, _) {
          final current = (_anim.value * _target).round();
          return Text('$_prefix$current$_suffix', style: widget.style);
        },
      ),
    );
  }
}

/// Card that lifts on hover — used for services, impact, partners, etc.
class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(26),
    this.accentBar = true,
    this.onTap,
    this.background = AppColors.white,
    this.accentColor = AppColors.red600,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool accentBar;
  final VoidCallback? onTap;
  final Color background;
  final Color accentColor;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hover ? -6 : 0, 0),
          decoration: BoxDecoration(
            color: widget.background,
            borderRadius: BorderRadius.circular(AppSizing.radius),
            border: Border.all(
              color: _hover ? widget.accentColor : AppColors.slate200,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.navy900.withValues(alpha: _hover ? 0.14 : 0.05),
                blurRadius: _hover ? 30 : 16,
                offset: Offset(0, _hover ? 18 : 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizing.radius),
            child: Stack(
              children: [
                Padding(padding: widget.padding, child: widget.child),
                if (widget.accentBar)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: _hover ? 5 : 0,
                      color: widget.accentColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Dark hero banner shown at the top of interior pages (`.page-head`).
class PageBanner extends StatelessWidget {
  const PageBanner({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.image,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizing.isMobile(context);
    return Container(
      width: double.infinity,
      color: AppColors.navy900,
      child: Stack(
        children: [
          if (image != null)
            Positioned.fill(
              child: Opacity(
                opacity: 0.20,
                child: Image.asset(image!, fit: BoxFit.cover),
              ),
            ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.navy900.withValues(alpha: 0.95),
                    AppColors.navy900.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -60,
            top: -40,
            child: _GlowBlob(color: AppColors.red600.withValues(alpha: 0.25)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: isMobile ? 64 : 96),
            child: ContentContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Eyebrow('Deopel', color: AppColors.redSoft),
                  const SizedBox(height: 16),
                  Eyebrow(eyebrow, color: AppColors.redSoft),
                  const SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 820),
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                            color: AppColors.white,
                            fontSize: isMobile ? 30 : 44,
                          ),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: Text(
                        subtitle!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white70),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 320,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color, blurRadius: 160, spreadRadius: 40)],
      ),
    );
  }
}

/// Bullet row with a green check used in the "Why Deopel" list.
class CheckItem extends StatelessWidget {
  const CheckItem(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: AppColors.green050,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_rounded,
                size: 16, color: AppColors.green700),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.slate700,
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A light, decorative section background: a soft gradient with two faint
/// brand-coloured glows. Adds depth to otherwise-plain sections.
class SoftSection extends StatelessWidget {
  const SoftSection({super.key, required this.child, this.small = false});
  final Widget child;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizing.isMobile(context);
    final v = small ? (isMobile ? 48.0 : 64.0) : (isMobile ? 64.0 : 96.0);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF6F8FE), Color(0xFFEEF2FB)],
        ),
      ),
      child: ClipRect(
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -60,
              child: _glow(AppColors.navy700.withValues(alpha: 0.10)),
            ),
            Positioned(
              bottom: -100,
              left: -70,
              child: _glow(AppColors.green600.withValues(alpha: 0.08)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: v),
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _glow(Color color) => Container(
        width: 340,
        height: 340,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: color, blurRadius: 150, spreadRadius: 60),
          ],
        ),
      );
}

/// Standard vertical padding wrapper for a page section.
class SectionPadding extends StatelessWidget {
  const SectionPadding({
    super.key,
    required this.child,
    this.color,
    this.small = false,
  });
  final Widget child;
  final Color? color;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizing.isMobile(context);
    final v = small ? (isMobile ? 48.0 : 64.0) : (isMobile ? 64.0 : 96.0);
    return Container(
      width: double.infinity,
      color: color,
      padding: EdgeInsets.symmetric(vertical: v),
      child: child,
    );
  }
}

/// Chooses a column count for a wrapped grid based on the actual available
/// [maxWidth] (not the screen width), so it stays correct during route
/// transitions and inside constrained containers.
int gridColumnsFor(double maxWidth, {double minItemWidth = 300, int maxColumns = 3}) {
  if (!maxWidth.isFinite || maxWidth <= 0) return 1;
  final fit = (maxWidth / minItemWidth).floor();
  return fit.clamp(1, maxColumns);
}

/// A safe per-item width for a wrapped grid. Never returns a negative value,
/// which would otherwise throw "BoxConstraints has a negative minimum width".
double gridItemWidth(double maxWidth, int columns, {double spacing = 24}) {
  if (!maxWidth.isFinite || maxWidth <= 0 || columns < 1) return 0;
  final w = (maxWidth - spacing * (columns - 1)) / columns;
  return w < 0 ? 0 : w;
}

/// A single column in a [ResponsiveRow]. [flex] > 0 makes it expand to fill
/// available width on wide screens; [flex] == 0 keeps the child's own width.
class Flexed {
  const Flexed(this.flex, this.child);
  final int flex;
  final Widget child;
}

/// Lays children out horizontally (using [Expanded] for [flex] > 0) on wide
/// screens, and stacks them vertically on narrow screens.
///
/// This avoids using [Expanded] inside a vertical [Flex], which would force an
/// infinite height when placed inside a scroll view.
class ResponsiveRow extends StatelessWidget {
  const ResponsiveRow({
    super.key,
    required this.children,
    this.spacing = 40,
    this.stackBelow = AppSizing.tabletBreakpoint,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final List<Flexed> children;
  final double spacing;
  final double stackBelow;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final stacked = MediaQuery.sizeOf(context).width < stackBelow;

    if (stacked) {
      final kids = <Widget>[];
      for (var i = 0; i < children.length; i++) {
        kids.add(children[i].child);
        if (i != children.length - 1) kids.add(SizedBox(height: spacing));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: kids,
      );
    }

    final kids = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      final c = children[i];
      kids.add(c.flex > 0 ? Expanded(flex: c.flex, child: c.child) : c.child);
      if (i != children.length - 1) kids.add(SizedBox(width: spacing));
    }
    return Row(crossAxisAlignment: crossAxisAlignment, children: kids);
  }
}

