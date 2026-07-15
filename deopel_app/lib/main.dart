import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import 'theme/app_theme.dart';
import 'widgets/site_header.dart';
import 'widgets/site_footer.dart';
import 'widgets/floating_actions.dart';
import 'pages/home_page.dart';
import 'pages/who_page.dart';
import 'pages/what_page.dart';
import 'pages/mission_page.dart';
import 'pages/impact_page.dart';
import 'pages/partners_page.dart';
import 'pages/clients_page.dart';
import 'pages/gallery_page.dart';
import 'pages/contact_page.dart';
import 'pages/service_detail_pages.dart';

void main() {
  // Clean URLs without the leading "#/" (e.g. /contact instead of /#/contact).
  usePathUrlStrategy();
  runApp(const DeopelApp());
}

class DeopelApp extends StatelessWidget {
  const DeopelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Deopel Engineering Associates Limited',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => SiteShell(child: child),
      routes: [
        _page('/', const HomePage()),
        _page('/about-us', const WhoPage()),
        _page('/mission', const MissionPage()),
        _page('/impact', const ImpactPage()),
        _page('/what', const WhatPage()),
        _page('/services/electrical', const ElectricalServicePage()),
        _page('/services/mechanical', const MechanicalServicePage()),
        _page('/services/environmental', const EnvironmentalServicePage()),
        _page('/capacity-building', const CapacityBuildingPage()),
        _page('/capacity-building/engineering-designs',
            const EngineeringDesignsPage()),
        _page('/partners', const PartnersPage()),
        _page('/clients', const ClientsPage()),
        _page('/gallery', const GalleryPage()),
        _page('/contact', const ContactPage()),
      ],
    ),
  ],
);

GoRoute _page(String path, Widget child) {
  return GoRoute(
    path: path,
    // Instant page swaps. A fading/animated transition overlaps the outgoing
    // and incoming pages, which lays them out at transient sizes and can race
    // element deactivation (throwing `_dependents.isEmpty`). Swapping without
    // an animation keeps each route's lifecycle isolated and stable.
    pageBuilder: (context, state) => NoTransitionPage(
      key: state.pageKey,
      child: child,
    ),
  );
}

/// App shell: fixed header, scrollable content + footer, and a mobile drawer.
/// Resets scroll to top whenever the route changes.
class SiteShell extends StatefulWidget {
  const SiteShell({super.key, required this.child});
  final Widget child;

  @override
  State<SiteShell> createState() => _SiteShellState();
}

class _SiteShellState extends State<SiteShell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  String? _lastPath;
  bool _showToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final show = _scrollController.hasClients && _scrollController.offset > 500;
    if (show != _showToTop) setState(() => _showToTop = show);
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    if (_lastPath != null &&
        _lastPath != path &&
        _scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) _scrollController.jumpTo(0);
      });
    }
    _lastPath = path;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white,
      endDrawer: const MobileNavDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              SiteHeader(
                onOpenMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      widget.child,
                      const SiteFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          FloatingActions(
            showToTop: _showToTop,
            onToTop: _scrollToTop,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
