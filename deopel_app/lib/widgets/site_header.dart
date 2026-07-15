import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Sticky top navigation bar. Shows inline links on desktop and a hamburger
/// that opens an end drawer on mobile.
class SiteHeader extends StatelessWidget {
  const SiteHeader({super.key, this.onOpenMenu});
  final VoidCallback? onOpenMenu;

  @override
  Widget build(BuildContext context) {
    // Show the full inline nav only when there is enough room for both the
    // full brand lockup and every nav item; otherwise use the hamburger.
    final showFullNav = MediaQuery.sizeOf(context).width >= 1150;
    final currentRoute = GoRouterState.of(context).uri.path;

    return Material(
      color: AppColors.white,
      elevation: 0,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.slate200)),
        ),
        child: ContentContainer(
          child: SizedBox(
            height: 78,
            child: Row(
              children: [
                // On desktop the brand takes its natural (full) width so the
                // company name never truncates; the Spacer alone absorbs the
                // free space. On tablet/mobile it may flex to avoid overflow.
                if (showFullNav)
                  _Brand(onTap: () => context.go('/'))
                else
                  Flexible(child: _Brand(onTap: () => context.go('/'))),
                const Spacer(),
                if (showFullNav) ...[
                  for (final item in kNavItems)
                    _NavEntry(item: item, currentRoute: currentRoute),
                  const SizedBox(width: 12),
                  BrandButton(
                    label: 'Get in Touch',
                    onPressed: () => context.go('/contact'),
                  ),
                ] else
                  IconButton(
                    onPressed: onOpenMenu,
                    icon: const Icon(Icons.menu, color: AppColors.navy900),
                    iconSize: 28,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(SiteInfo.logoAsset, height: 56),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    SiteInfo.companyName,
                    style: GoogleFonts.montserrat(
                      fontSize: 25,
                      height: 1,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      color: AppColors.navy900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    SiteInfo.tagline.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navy700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavEntry extends StatefulWidget {
  const _NavEntry({required this.item, required this.currentRoute});
  final NavItem item;
  final String currentRoute;

  @override
  State<_NavEntry> createState() => _NavEntryState();
}

class _NavEntryState extends State<_NavEntry> {
  final OverlayPortalController _portal = OverlayPortalController();
  final LayerLink _link = LayerLink();
  bool _hover = false;
  Timer? _closeTimer;

  bool get _isActive {
    if (widget.currentRoute == widget.item.route) return true;
    return widget.item.children.any((c) => c.route == widget.currentRoute);
  }

  /// Show the overlay outside the current mouse-tracker device update to avoid
  /// the `mouse_tracker.dart` reentrancy assertion.
  void _open() {
    _closeTimer?.cancel();
    if (_portal.isShowing) return;
    scheduleMicrotask(() {
      if (mounted && !_portal.isShowing) _portal.show();
    });
  }

  void _scheduleClose() {
    _closeTimer?.cancel();
    _closeTimer = Timer(const Duration(milliseconds: 140), () {
      if (mounted && _portal.isShowing) _portal.hide();
    });
  }

  @override
  void dispose() {
    _closeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.children.isEmpty) {
      return _NavLink(
        label: widget.item.label,
        active: _isActive,
        onTap: () => context.go(widget.item.route),
      );
    }

    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _portal,
        overlayChildBuilder: (context) {
          return Positioned(
            width: 220,
            child: CompositedTransformFollower(
              link: _link,
              targetAnchor: Alignment.bottomLeft,
              followerAnchor: Alignment.topLeft,
              offset: const Offset(0, 6),
              child: MouseRegion(
                onEnter: (_) => _open(),
                onExit: (_) => _scheduleClose(),
                child: _DropdownPanel(
                  items: widget.item.children,
                  currentRoute: widget.currentRoute,
                  onSelect: (route) {
                    _portal.hide();
                    context.go(route);
                  },
                ),
              ),
            ),
          );
        },
        child: MouseRegion(
          onEnter: (_) {
            setState(() => _hover = true);
            _open();
          },
          onExit: (_) {
            setState(() => _hover = false);
            _scheduleClose();
          },
          child: _NavLink(
            label: widget.item.label,
            active: _isActive,
            trailing: Icons.keyboard_arrow_down_rounded,
            expanded: _hover,
            onTap: () => context.go(widget.item.route),
          ),
        ),
      ),
    );
  }
}

/// The floating panel of sub-links shown under a nav entry.
class _DropdownPanel extends StatelessWidget {
  const _DropdownPanel({
    required this.items,
    required this.currentRoute,
    required this.onSelect,
  });
  final List<NavItem> items;
  final String currentRoute;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.slate200),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy900.withValues(alpha: 0.14),
              blurRadius: 30,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final child in items)
              _DropdownItem(
                label: child.label,
                active: child.route == currentRoute,
                onTap: () => onSelect(child.route),
              ),
          ],
        ),
      ),
    );
  }
}

class _DropdownItem extends StatefulWidget {
  const _DropdownItem({
    required this.label,
    required this.onTap,
    this.active = false,
  });
  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  State<_DropdownItem> createState() => _DropdownItemState();
}

class _DropdownItemState extends State<_DropdownItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = widget.active || _hover;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            color: highlighted ? AppColors.green050 : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: highlighted ? 6 : 0,
                height: 6,
                margin: EdgeInsets.only(right: highlighted ? 10 : 0),
                decoration: const BoxDecoration(
                  color: AppColors.green600,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontWeight:
                        highlighted ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14.5,
                    letterSpacing: 0.1,
                    color: highlighted
                        ? AppColors.navy900
                        : AppColors.slate700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.onTap,
    this.active = false,
    this.trailing,
    this.expanded = false,
  });
  final String label;
  final VoidCallback onTap;
  final bool active;
  final IconData? trailing;
  final bool expanded;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.active;
    final soft = _hover || widget.expanded;
    final highlighted = active || soft;

    final Color bg = active
        ? AppColors.green600
        : (soft ? AppColors.green050 : Colors.transparent);
    final Color fg = active
        ? AppColors.white
        : (soft ? AppColors.green700 : AppColors.slate700);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 14.5,
                  letterSpacing: 0.2,
                  fontWeight: highlighted ? FontWeight.w600 : FontWeight.w500,
                  color: fg,
                ),
                child: Text(widget.label),
              ),
              if (widget.trailing != null) ...[
                const SizedBox(width: 4),
                AnimatedRotation(
                  turns: widget.expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 220),
                  child: Icon(widget.trailing, size: 18, color: fg),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The slide-in mobile navigation drawer.
class MobileNavDrawer extends StatelessWidget {
  const MobileNavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    return Drawer(
      backgroundColor: AppColors.navy900,
      width: MediaQuery.sizeOf(context).width * 0.82,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(SiteInfo.logoAsset, height: 40),
                      const SizedBox(width: 10),
                      Text(
                        SiteInfo.companyName,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: AppColors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    for (final item in kNavItems) ...[
                      _MobileLink(
                        label: item.label,
                        active: currentRoute == item.route,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.go(item.route);
                        },
                      ),
                      for (final child in item.children)
                        _MobileLink(
                          label: child.label,
                          indented: true,
                          active: currentRoute == child.route,
                          onTap: () {
                            Navigator.of(context).pop();
                            context.go(child.route);
                          },
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: BrandButton(
                  label: 'Get in Touch',
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.go('/contact');
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileLink extends StatelessWidget {
  const _MobileLink({
    required this.label,
    required this.onTap,
    this.active = false,
    this.indented = false,
  });
  final String label;
  final VoidCallback onTap;
  final bool active;
  final bool indented;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          left: indented ? 20 : 4,
          top: indented ? 12 : 16,
          bottom: indented ? 12 : 16,
        ),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white12)),
        ),
        child: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: indented ? 15 : 19,
            fontWeight: indented ? FontWeight.w500 : FontWeight.w600,
            color: active
                ? AppColors.redSoft
                : (indented ? Colors.white70 : AppColors.white),
          ),
        ),
      ),
    );
  }
}
