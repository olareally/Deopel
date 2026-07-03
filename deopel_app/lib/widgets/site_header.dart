import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    final isTablet = AppSizing.isTablet(context);
    final currentRoute = GoRouterState.of(context).uri.path;

    return Material(
      color: AppColors.white.withValues(alpha: 0.94),
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.slate200)),
        ),
        child: ContentContainer(
          child: SizedBox(
            height: 78,
            child: Row(
              children: [
                _Brand(onTap: () => context.go('/')),
                const Spacer(),
                if (!isTablet) ...[
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
            Image.asset(SiteInfo.logoAsset, height: 46),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  SiteInfo.companyName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        height: 1,
                      ),
                ),
                const SizedBox(height: 3),
                Text(
                  SiteInfo.tagline.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 9.5,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w500,
                    color: AppColors.slate500,
                  ),
                ),
              ],
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
            active: _isActive || _hover,
            trailing: Icons.keyboard_arrow_down_rounded,
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.slate200),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy900.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 12),
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          color: _hover ? AppColors.slate100 : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: (widget.active || _hover)
                  ? AppColors.navy900
                  : AppColors.slate700,
            ),
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
  });
  final String label;
  final VoidCallback onTap;
  final bool active;
  final IconData? trailing;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.active || _hover;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: _hover ? AppColors.slate100 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: active ? AppColors.navy900 : AppColors.slate700,
                    ),
                  ),
                  if (widget.trailing != null)
                    Icon(widget.trailing, size: 18, color: AppColors.slate500),
                ],
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 2,
                width: widget.active ? 20 : 0,
                decoration: BoxDecoration(
                  color: AppColors.red600,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
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
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
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
