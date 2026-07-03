import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Dark footer with brand blurb, quick links and contact details.
class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizing.isMobile(context);
    return Container(
      width: double.infinity,
      color: AppColors.navy900,
      padding: EdgeInsets.symmetric(vertical: isMobile ? 48 : 72),
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveRow(
              spacing: 40,
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
            const SizedBox(height: 40),
            const Divider(color: Colors.white12, height: 1),
            const SizedBox(height: 24),
            Text(
              '© 2026 ${SiteInfo.companyFull}. All rights reserved.',
              style: const TextStyle(color: Colors.white54, fontSize: 13.5),
            ),
          ],
        ),
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
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(SiteInfo.logoAsset, height: 40),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  SiteInfo.companyName,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.white),
                ),
                Text(
                  SiteInfo.tagline,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: const Text(
            'A capacity-building partner training and retraining young school '
            'leavers, graduates and professionals in artisan and engineering '
            'skills for self-sustainability across Nigeria.',
            style: TextStyle(color: Colors.white70, height: 1.6, fontSize: 14.5),
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: const [
            _SocialButton(Icons.public),
            _SocialButton(Icons.facebook),
            _SocialButton(Icons.alternate_email),
            _SocialButton(Icons.phone),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton(this.icon);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 18, color: Colors.white70),
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
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 16),
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
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _hover ? AppColors.white : Colors.white60,
              fontSize: 14.5,
            ),
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
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 16),
        _contactRow(Icons.phone_outlined, SiteInfo.phone),
        _contactRow(Icons.mail_outline, SiteInfo.email),
        _contactRow(Icons.location_on_outlined, SiteInfo.location),
      ],
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.redSoft),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 14.5),
            ),
          ),
        ],
      ),
    );
  }
}
