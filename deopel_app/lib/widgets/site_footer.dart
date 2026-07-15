import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import '../utils/launchers.dart';
import 'common.dart';

/// Dark footer with brand blurb, quick links and contact details.
class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizing.isMobile(context);
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0B1738), AppColors.navy900],
        ),
      ),
      child: Column(
        children: [
          // Brand accent ribbon across the very top of the footer.
          Container(
            height: 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.red600,
                  AppColors.red700,
                  AppColors.green600,
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: isMobile ? 48 : 76),
            child: ContentContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveRow(
                    spacing: 48,
                    stackBelow: AppSizing.mobileBreakpoint,
                    children: [
                      const Flexed(5, _FooterBrand()),
                      Flexed(
                        3,
                        _FooterLinks(
                          title: 'Company',
                          links: const {
                            'About Us': '/about-us',
                            'Mission': '/mission',
                            'Our Impact': '/impact',
                            'What We Do': '/what',
                          },
                        ),
                      ),
                      Flexed(
                        3,
                        _FooterLinks(
                          title: 'Explore',
                          links: const {
                            'Partners': '/partners',
                            'Clients': '/clients',
                            'Gallery': '/gallery',
                            'Contact': '/contact',
                          },
                        ),
                      ),
                      const Flexed(4, _FooterContact()),
                    ],
                  ),
                  const SizedBox(height: 44),
                  const Divider(color: Colors.white12, height: 1),
                  const SizedBox(height: 22),
                  const _FooterBottomBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Image.asset(SiteInfo.logoAsset, height: 44),
            ),
            const SizedBox(width: 14),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    SiteInfo.companyName,
                    style: GoogleFonts.montserrat(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      height: 1,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    SiteInfo.tagline.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      color: Colors.white70,
                      fontSize: 10,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: const Text(
            'A capacity-building partner training and retraining young school '
            'leavers, graduates and professionals in artisan and engineering '
            'skills for self-sustainability across Nigeria.',
            style: TextStyle(color: Colors.white70, height: 1.7, fontSize: 14.5),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _SocialButton(Icons.language, 'Website', Launch.website),
            _SocialButton(Icons.chat, 'WhatsApp', () => Launch.whatsApp()),
            _SocialButton(Icons.alternate_email, 'Email', Launch.email),
            _SocialButton(Icons.call, 'Call', Launch.phone),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton(this.icon, this.tooltip, this.onTap);
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Tooltip(
        message: widget.tooltip,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hover = true),
          onExit: (_) => setState(() => _hover = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: _hover ? AppColors.red600 : Colors.white10,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _hover ? AppColors.red600 : Colors.white12,
                ),
              ),
              child: Icon(
                widget.icon,
                size: 18,
                color: _hover ? AppColors.white : Colors.white70,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterLinks extends StatelessWidget {
  const _FooterLinks({required this.title, required this.links});
  final String title;
  final Map<String, String> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 26,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.red600,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 18),
        for (final entry in links.entries)
          _FooterLink(label: entry.key, route: entry.value),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  const _FooterLink({required this.label, required this.route});
  final String label;
  final String route;

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
        onTap: () => context.go(widget.route),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 13),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 18,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: _hover ? 1 : 0,
                  child: const Icon(Icons.chevron_right,
                      size: 16, color: AppColors.redSoft),
                ),
              ),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: TextStyle(
                  color: _hover ? AppColors.white : Colors.white60,
                  fontSize: 14.5,
                  fontWeight: _hover ? FontWeight.w500 : FontWeight.w400,
                ),
                child: Text(widget.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterContact extends StatelessWidget {
  const _FooterContact();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Get in touch',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 26,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.red600,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 18),
        _contactRow(Icons.call_outlined, SiteInfo.phone, Launch.phone),
        _contactRow(Icons.mail_outline, SiteInfo.email, Launch.email),
        _contactRow(Icons.language_outlined, SiteInfo.website, Launch.website),
        _contactRow(
            Icons.location_on_outlined, SiteInfo.location, Launch.maps),
      ],
    );
  }

  Widget _contactRow(IconData icon, String text, VoidCallback onTap) {
    return _FooterContactRow(icon: icon, text: text, onTap: onTap);
  }
}

class _FooterContactRow extends StatefulWidget {
  const _FooterContactRow({
    required this.icon,
    required this.text,
    required this.onTap,
  });
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  State<_FooterContactRow> createState() => _FooterContactRowState();
}

class _FooterContactRowState extends State<_FooterContactRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _hover ? AppColors.red600 : Colors.white10,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(widget.icon,
                    size: 16,
                    color: _hover ? AppColors.white : AppColors.redSoft),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: _hover ? AppColors.white : Colors.white70,
                      fontSize: 14,
                      height: 1.4,
                    ),
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

/// Copyright + registration metadata, stacked on mobile.
class _FooterBottomBar extends StatelessWidget {
  const _FooterBottomBar();

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizing.isMobile(context);
    final copyright = Text(
      '© 2026 ${SiteInfo.companyFull}. All rights reserved.',
      style: const TextStyle(color: Colors.white54, fontSize: 13.5),
    );
    const meta = Text(
      'Consulting & Contracting Engineers · RC 371,113',
      style: TextStyle(
        color: Colors.white38,
        fontSize: 12.5,
        letterSpacing: 0.3,
      ),
    );
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [copyright, const SizedBox(height: 8), meta],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [copyright, meta],
    );
  }
}
