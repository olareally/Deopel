import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'theme/app_theme.dart';
import 'widgets/site_header.dart';
import 'widgets/site_footer.dart';
import 'pages/home_page.dart';
import 'pages/who_page.dart';
import 'pages/what_page.dart';
import 'pages/mission_page.dart';
import 'pages/impact_page.dart';
import 'pages/partners_page.dart';
import 'pages/clients_page.dart';
import 'pages/gallery_page.dart';
import 'pages/contact_page.dart';

void main() {
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
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, _, widget) {
        return FadeTransition(opacity: animation, child: widget);
      },
      transitionDuration: const Duration(milliseconds: 300),
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
      body: Column(
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
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
