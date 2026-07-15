import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _HeroSlider(),
        _StatsStrip(),
        _AboutTeaser(),
        _ServicesSection(),
        _StatsBand(),
        _ClientsMarquee(),
        _CtaBand(),
      ],
    );
  }
}

/// ============ HERO (auto-rotating slider) ============
class _HeroSlider extends StatefulWidget {
  const _HeroSlider();

  @override
  State<_HeroSlider> createState() => _HeroSliderState();
}

class _HeroSliderState extends State<_HeroSlider> {
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      setState(() => _index = (_index + 1) % kHeroSlides.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizing.isMobile(context);
    final slide = kHeroSlides[_index];

    return SizedBox(
      height: isMobile ? 560 : 620,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Crossfading background image (fills the full hero width)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 900),
            child: SizedBox.expand(
              key: ValueKey(slide.image),
              child: Image.asset(
                slide.image,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          // Gradient overlay for readability
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.navy900.withValues(alpha: 0.94),
                    AppColors.navy900.withValues(alpha: 0.78),
                    AppColors.navy900.withValues(alpha: 0.45),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.red600.withValues(alpha: 0.3),
                    blurRadius: 180,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),
          // Copy
          Align(
            alignment: Alignment.centerLeft,
            child: ContentContainer(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _HeroCopy(
                  key: ValueKey(_index),
                  slide: slide,
                  isMobile: isMobile,
                ),
              ),
            ),
          ),
          // Slide indicators
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < kHeroSlides.length; i++)
                  GestureDetector(
                    onTap: () => setState(() => _index = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: i == _index ? 44 : 28,
                      height: 4,
                      decoration: BoxDecoration(
                        color: i == _index
                            ? AppColors.red600
                            : Colors.white.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({super.key, required this.slide, required this.isMobile});
  final HeroSlide slide;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Eyebrow(slide.eyebrow, color: AppColors.redSoft),
          const SizedBox(height: 18),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.white,
                    fontSize: isMobile ? 34 : 52,
                    height: 1.1,
                  ),
              children: [
                TextSpan(text: slide.title),
                TextSpan(
                  text: slide.accent,
                  style: const TextStyle(color: AppColors.redSoft),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            slide.body,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.88),
                ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              BrandButton(
                label: 'Start a Program',
                onPressed: () => context.go('/contact'),
              ),
              BrandButton(
                label: 'Explore What We Do',
                variant: BrandButtonVariant.outline,
                showArrow: false,
                onPressed: () => context.go('/what'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ============ STATS STRIP (dark band under hero) ============
class _StatsStrip extends StatelessWidget {
  const _StatsStrip();

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizing.isMobile(context);
    return Container(
      width: double.infinity,
      color: const Color(0xFF081235),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ContentContainer(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 8,
          children: [
            for (final stat in kStats)
              SizedBox(
                width: isMobile
                    ? (MediaQuery.sizeOf(context).width - 40) / 2
                    : 240,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CountUp(
                        stat.value,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: AppColors.white, fontSize: 30),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stat.label,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// ============ ABOUT TEASER ============
class _AboutTeaser extends StatelessWidget {
  const _AboutTeaser();

  @override
  Widget build(BuildContext context) {
    return SoftSection(
      child: ContentContainer(
        child: ResponsiveRow(
          spacing: 48,
          children: [
            Flexed(
              6,
              Reveal(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Eyebrow('Why Deopel'),
                    const SizedBox(height: 14),
                    Text(
                      'A capacity-building partner focused on youth, '
                      'self-reliance and real skills.',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 30),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'We train and retrain young school leavers and graduates '
                      'in artisan skills and engineering software for '
                      'self-sustainability and development — delivered with '
                      'partner workshops and recognised credentials.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    const CheckItem(
                        'Training that supports entrepreneurship and self-employment.'),
                    const CheckItem(
                        'Practical workshop placement for skills beyond our own equipment.'),
                    const CheckItem(
                        'Programs for NGOs, government, corporate organizations and private clients.'),
                    const CheckItem(
                        'Nationally recognised certificates and placement opportunities.'),
                    const SizedBox(height: 26),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BrandButton(
                        label: 'More about us',
                        variant: BrandButtonVariant.dark,
                        onPressed: () => context.go('/about-us'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexed(
              5,
              Reveal(
                delayMs: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizing.radiusLg),
                  child: AspectRatio(
                    aspectRatio: 4 / 3.2,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset('assets/images/weld2.jpg',
                            fit: BoxFit.cover),
                        Positioned(
                          left: 18,
                          bottom: 18,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(999),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.navy900
                                      .withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star_rounded,
                                    color: AppColors.red600, size: 18),
                                SizedBox(width: 6),
                                Text(
                                  'Self-sustainability first',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.navy900,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============ SERVICES GRID ============
class _ServicesSection extends StatelessWidget {
  const _ServicesSection();

  @override
  Widget build(BuildContext context) {
    return SectionPadding(
      child: ContentContainer(
        child: Column(
          children: [
            const Reveal(
              child: SectionHeader(
                eyebrow: 'What We Do',
                title:
                    'Practical capacity building across artisans, engineering and industry skills',
                lede:
                    'From building services and oil & gas to design, media and '
                    'agriculture — one partner preparing youth for self-reliant careers.',
              ),
            ),
            const SizedBox(height: 48),
            ServicesGrid(services: kServices),
            const SizedBox(height: 44),
            BrandButton(
              label: 'View all services',
              onPressed: () => context.go('/what'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Responsive grid of service cards, reused on the What We Do page.
class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key, required this.services});
  final List<ServiceItem> services;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 24.0;
        final columns = gridColumnsFor(constraints.maxWidth,
            minItemWidth: 300, maxColumns: 3);
        final cardWidth =
            gridItemWidth(constraints.maxWidth, columns, spacing: gap);
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (int i = 0; i < services.length; i++)
              SizedBox(
                width: cardWidth,
                child: Reveal(
                  delayMs: (i % columns) * 90,
                  child: _ServiceCard(
                    service: services[i],
                    color: kServiceColors[i % kServiceColors.length],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// A tint + solid pair used to colour each service card.
class ServiceColor {
  const ServiceColor(this.tint, this.solid);
  final Color tint;
  final Color solid;
}

const List<ServiceColor> kServiceColors = [
  ServiceColor(Color(0xFFFEF2F2), Color(0xFFED1C24)), // red
  ServiceColor(Color(0xFFEAF7EE), Color(0xFF22B14C)), // green
  ServiceColor(Color(0xFFEAF1FF), Color(0xFF2563EB)), // blue
  ServiceColor(Color(0xFFFFF4E6), Color(0xFFE8890C)), // amber
  ServiceColor(Color(0xFFF3EEFE), Color(0xFF7C3AED)), // purple
  ServiceColor(Color(0xFFE7FAF5), Color(0xFF0D9488)), // teal
];

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service, required this.color});
  final ServiceItem service;
  final ServiceColor color;

  @override
  Widget build(BuildContext context) {
    final hasLink = service.route != null;
    return HoverCard(
      padding: const EdgeInsets.fromLTRB(26, 28, 26, 26),
      background: color.tint,
      accentColor: color.solid,
      onTap: hasLink ? () => context.go(service.route!) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: color.solid,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: color.solid.withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(service.icon, color: AppColors.white, size: 26),
          ),
          const SizedBox(height: 20),
          Text(
            service.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  height: 1.25,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            service.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (hasLink) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Learn more',
                  style: TextStyle(
                    color: color.solid,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.arrow_forward, size: 16, color: color.solid),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// ============ STATS BAND (navy, big numbers) ============
Widget _glowCircle(Color color, {double size = 340}) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color, blurRadius: 150, spreadRadius: 60),
        ],
      ),
    );

class _StatsBand extends StatelessWidget {
  const _StatsBand();

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizing.isMobile(context);
    const bandStats = [
      Stat('500+', 'Youths trained'),
      Stat('6', 'Skill programs'),
      Stat('90%', 'Practical hands-on'),
      Stat('12+', 'Industry clients'),
    ];
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF17275F), AppColors.navy900, Color(0xFF0A1330)],
        ),
      ),
      child: ClipRect(
        child: Stack(
          children: [
            Positioned(
              top: -70,
              right: -50,
              child: _glowCircle(AppColors.red600.withValues(alpha: 0.22)),
            ),
            Positioned(
              bottom: -90,
              left: -60,
              child: _glowCircle(AppColors.green600.withValues(alpha: 0.16)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 56 : 80),
              child: ContentContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Reveal(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Eyebrow('Outcomes you can measure',
                              color: AppColors.redSoft),
                          const SizedBox(height: 14),
                          Text(
                            'Built to build people — every program, every trainee.',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: AppColors.white, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      runSpacing: 28,
                      children: [
                        for (final stat in bandStats)
                          SizedBox(
                            width: isMobile
                                ? (MediaQuery.sizeOf(context).width - 40) / 2
                                : 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CountUp(
                                  stat.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        color: AppColors.white,
                                        fontSize: 44,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  stat.label,
                                  style: const TextStyle(
                                      color: Colors.white60, fontSize: 14.5),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============ CLIENTS MARQUEE ============
class _ClientsMarquee extends StatefulWidget {
  const _ClientsMarquee();

  @override
  State<_ClientsMarquee> createState() => _ClientsMarqueeState();
}

class _ClientsMarqueeState extends State<_ClientsMarquee>
    with SingleTickerProviderStateMixin {
  late final ScrollController _controller;
  late final Ticker _ticker;

  static const List<String> _names = [
    'NDDC',
    'SPDC (Shell)',
    'NLNG',
    'NCDMB',
    'Rivers State MoP',
    'RSSDA',
    'Ministry of Works',
    'Youth Development',
  ];

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration _) {
    if (!_controller.hasClients) return;
    final position = _controller.position;
    if (!position.hasContentDimensions) return;
    final max = position.maxScrollExtent;
    if (max <= 0) return;
    var next = _controller.offset + 0.6;
    if (next >= max) next = 0;
    _controller.jumpTo(next);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loop = [..._names, ..._names, ..._names];
    return SectionPadding(
      small: true,
      color: AppColors.bgSoft,
      child: Column(
        children: [
          Text(
            'TRUSTED BY GOVERNMENT AGENCIES, NGOS & INDUSTRY PARTNERS',
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.slate500,
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 52,
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: loop.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.slate200),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.navy900.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.green600,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          loop[i],
                          style: GoogleFonts.montserrat(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.navy800,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// ============ CTA BAND ============
class _CtaBand extends StatelessWidget {
  const _CtaBand();

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizing.isMobile(context);
    return SectionPadding(
      small: true,
      child: ContentContainer(
        child: Reveal(
          child: Container(
            padding: EdgeInsets.all(isMobile ? 28 : 48),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizing.radiusLg),
              gradient: const LinearGradient(
                colors: [AppColors.red600, AppColors.red700],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.red600.withValues(alpha: 0.35),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: ResponsiveRow(
              spacing: 24,
              stackBelow: AppSizing.mobileBreakpoint,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Flexed(
                6,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ready to build a skill, a career or a business?',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: AppColors.white, fontSize: 26),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tell us the training you need. We will match you to the '
                      'right program, partner workshop and certification pathway.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 15.5,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Flexed(
                0,
                Align(
                  alignment: Alignment.centerLeft,
                  child: BrandButton(
                    label: 'Request a program',
                    variant: BrandButtonVariant.light,
                    onPressed: () => context.go('/contact'),
                  ),
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
