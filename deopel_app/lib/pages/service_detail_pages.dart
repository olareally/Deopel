import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';
import '../widgets/common.dart';

// ===========================================================================
// Shared building blocks
// ===========================================================================

/// Standard scaffold for a service detail page: dark banner + padded body.
class _DetailScaffold extends StatelessWidget {
  const _DetailScaffold({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.body,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final String image;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageBanner(
          eyebrow: eyebrow,
          title: title,
          subtitle: subtitle,
          image: image,
        ),
        SectionPadding(
          child: ContentContainer(child: body),
        ),
      ],
    );
  }
}

/// A responsive grid of "capability" check chips.
class _CapabilityGrid extends StatelessWidget {
  const _CapabilityGrid({required this.items, required this.accent});
  final List<String> items;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 16.0;
        final columns = gridColumnsFor(constraints.maxWidth,
            minItemWidth: 320, maxColumns: 2);
        final itemWidth =
            gridItemWidth(constraints.maxWidth, columns, spacing: gap);
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (var i = 0; i < items.length; i++)
              SizedBox(
                width: itemWidth,
                child: Reveal(
                  delayMs: (i % columns) * 70,
                  child: _CapabilityChip(text: items[i], accent: accent),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _CapabilityChip extends StatelessWidget {
  const _CapabilityChip({required this.text, required this.accent});
  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy900.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.check_rounded, size: 18, color: accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.navy900,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A titled "feature" card (title + description) used for design specs.
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.accent,
  });
  final IconData icon;
  final String title;
  final String description;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      accentColor: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent, size: 26),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 18, height: 1.25),
          ),
          const SizedBox(height: 10),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

/// Section title used inside a detail page body.
class _BodyHeading extends StatelessWidget {
  const _BodyHeading(this.eyebrow, this.title, {this.accent});
  final String eyebrow;
  final String title;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow(eyebrow, color: accent ?? AppColors.red600),
        const SizedBox(height: 12),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: 26),
        ),
      ],
    );
  }
}

class _RelatedCard {
  const _RelatedCard(this.icon, this.title, this.subtitle, this.route,
      this.accent);
  final IconData icon;
  final String title;
  final String subtitle;
  final String route;
  final Color accent;
}

/// Row of cards linking to related engineering service pages.
class _RelatedServices extends StatelessWidget {
  const _RelatedServices({required this.items});
  final List<_RelatedCard> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 24.0;
        final columns = gridColumnsFor(constraints.maxWidth,
            minItemWidth: 260, maxColumns: 3);
        final itemWidth =
            gridItemWidth(constraints.maxWidth, columns, spacing: gap);
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (var i = 0; i < items.length; i++)
              SizedBox(
                width: itemWidth,
                child: Reveal(
                  delayMs: (i % columns) * 80,
                  child: HoverCard(
                    accentColor: items[i].accent,
                    onTap: () => context.go(items[i].route),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: items[i].accent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(items[i].icon,
                              color: items[i].accent, size: 24),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          items[i].title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 17),
                        ),
                        const SizedBox(height: 8),
                        Text(items[i].subtitle,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('View service',
                                style: TextStyle(
                                    color: items[i].accent,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.5)),
                            const SizedBox(width: 6),
                            Icon(Icons.arrow_forward,
                                size: 15, color: items[i].accent),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// "Back to all services" + "Talk to us" actions.
class _DetailFooterActions extends StatelessWidget {
  const _DetailFooterActions();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        BrandButton(
          label: 'Request this service',
          onPressed: () => context.go('/contact'),
        ),
        BrandButton(
          label: 'All services',
          variant: BrandButtonVariant.dark,
          onPressed: () => context.go('/what'),
        ),
      ],
    );
  }
}

/// A titled category card used on the Capacity Building page.
/// Renders a bold category heading followed by a bulleted list of items.
class _CapacityCategory extends StatelessWidget {
  const _CapacityCategory({required this.title, required this.items});
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Reveal(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizing.radius),
          border: Border.all(color: AppColors.slate200),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy900.withValues(alpha: 0.04),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 5,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.red600,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.red600,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.bodyMedium,
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

// ===========================================================================
// 1. Electrical Engineering Installation / Construction Services
// ===========================================================================
class ElectricalServicePage extends StatelessWidget {
  const ElectricalServicePage({super.key});

  static const _accent = Color(0xFF2563EB);
  static const _items = [
    'Standby & Prime Power',
    'Distribution Transformers',
    'HV & LV Switchgear',
    'Conduit & Wiring',
    'Lighting Systems',
    'Data & Telephones',
    'Satellite TV Systems',
    'Fire Alarm Systems',
    'CCTV Systems',
    'Security Systems',
    'Public Address Systems',
    'Systems Earthing',
    'Lightning Protection Systems',
    'Street Lighting',
    'Rural Electrification',
  ];

  @override
  Widget build(BuildContext context) {
    return _DetailScaffold(
      eyebrow: 'Electrical Engineering',
      title: 'Installation & Construction Services',
      subtitle:
          'Procurement, installation and commissioning of electrical facilities '
          'for domestic, commercial and industrial projects.',
      image: 'assets/images/training-1.png',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                'Our capacity includes the skills to procure, install and '
                'commission a full range of electrical installation and '
                'construction works:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 32),
          _CapabilityGrid(items: _items, accent: _accent),
          const SizedBox(height: 40),
          const _DetailFooterActions(),
        ],
      ),
    );
  }
}

// ===========================================================================
// 2. Mechanical Engineering Design Services
// ===========================================================================
class MechanicalServicePage extends StatelessWidget {
  const MechanicalServicePage({super.key});

  static const _accent = AppColors.red600;
  static const _items = [
    'Plumbing System (Cold, Hot & Waste Water Lines)',
    'Water Treatment Plant',
    'Water Storage Tanks & Distribution Network',
    'Sprinkler System',
    'Wet & Dry Fire Hydrant Systems',
    'FM200 Fire Extinguishing Systems',
    'Central Sewage Treatment Plant / System',
    'Gas Supply & Distribution Network',
    'Swimming Pools',
    'Central & Split Air Conditioning Units',
  ];

  @override
  Widget build(BuildContext context) {
    return _DetailScaffold(
      eyebrow: 'Mechanical Engineering',
      title: 'Design Services',
      subtitle:
          'Design, procurement, installation and commissioning of mechanical '
          'facilities in domestic, commercial and industrial buildings.',
      image: 'assets/images/training-2.png',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                'Our capacity involves the skills to design, procure, install '
                'and commission mechanical facilities in domestic, commercial '
                'and industrial buildings, which include the following:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 32),
          _CapabilityGrid(items: _items, accent: _accent),
          const SizedBox(height: 40),
          const _DetailFooterActions(),
        ],
      ),
    );
  }
}

// ===========================================================================
// 3. Environmental Engineering Consultancy Services
// ===========================================================================
class EnvironmentalServicePage extends StatelessWidget {
  const EnvironmentalServicePage({super.key});

  static const _accent = AppColors.green600;
  static const _items = [
    'Municipal water supply distribution',
    'Central Gas supply / Distribution Installation',
    'Central Sewage Line and Treatment plant',
    'Waste Management',
  ];

  @override
  Widget build(BuildContext context) {
    return _DetailScaffold(
      eyebrow: 'Environmental Engineering',
      title: 'Consultancy Services',
      subtitle:
          'Profitable, sustainable solutions to the environmental challenges '
          'that affect the comfort of communities.',
      image: 'assets/images/training-room.png',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                'Our environmental engineers play key roles in understanding the '
                'various issues that challenge the fundamental comfort of the '
                'populace in their environments, and proffer profitable solutions '
                'in design and implementation to eliminate those challenges. We '
                'introduce unique approaches in design to the overall concept of '
                'environmental engineering by integrating different related '
                'processes of environmental issues.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const _BodyHeading(
            'Our Disciplines',
            'Disciplines in Environmental Engineering',
            accent: _accent,
          ),
          const SizedBox(height: 24),
          _CapabilityGrid(items: _items, accent: _accent),
          const SizedBox(height: 40),
          const _DetailFooterActions(),
        ],
      ),
    );
  }
}

// ===========================================================================
// 4. Capacity Building
// ===========================================================================
class CapacityBuildingPage extends StatelessWidget {
  const CapacityBuildingPage({super.key});

  static const _accent = AppColors.red600;
  static const _leverages = [
    (
      Icons.rocket_launch_outlined,
      'Become an entrepreneur',
      'Graduates gain the skills and confidence to start and run their own ventures.',
    ),
    (
      Icons.self_improvement_outlined,
      'Self-employed & self-reliant',
      'Trainees become self-employed, self-reliant and self-actualized professionals.',
    ),
    (
      Icons.groups_outlined,
      'Employers & trainers',
      'They become labour employers and trainers, attaching young apprentices to their '
          'job executions — reducing the unemployment rate.',
    ),
    (
      Icons.factory_outlined,
      'Industry-ready',
      'They become employable in the oil & gas sector, process and manufacturing '
          'industries, and the building industry.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _DetailScaffold(
      eyebrow: 'Capacity Building',
      title: 'Building Services & Artisan Skills',
      subtitle:
          'Training and retraining young school leavers and graduates in artisan '
          'and software engineering skills for self-sustainability.',
      image: 'assets/images/training.png',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Text(
                'DEOPEL Engineering has a wide spectrum of partners who have '
                'competent and practical workshops for training collaborations '
                'in terms of job training and placement of youths in all our '
                'fields of training scheme.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 40),
          const _BodyHeading(
            'Programs',
            'Sets of Capacity Buildings',
            accent: _accent,
          ),
          const SizedBox(height: 24),
          const _CapacityCategory(
            title: 'Building Services & Artisans Skills Capacity Building',
            items: [
              'Domestic and industrial facility electrical wiring and installations',
              'Electrical wiring for domestic and industrial electrical facilities',
              'Extra low voltage systems: access control, alarm system, solar panel system installations',
              'Plumbing and pipe fitting installations for domestic and industrial facilities',
              'Air conditioning and refrigerator installation and maintenance for domestic and industrial facilities',
              'Construction of fueless / infinite generator sets',
              'Aluminium profile fabrications and installations — doors, windows and vents',
              'POP casting and installation techniques',
              'Tiling techniques (internal and external)',
              'Plastering and screeding techniques',
              'Paint making and painting works',
              'Pipe and structural welding works',
              'Scaffolding and erection techniques',
            ],
          ),
          const SizedBox(height: 20),
          const _CapacityCategory(
            title: 'Oil & Gas Industry Skills Capacity Building',
            items: [
              'Process control and instrumentation',
              'Calibration and installation of instruments / equipment',
              'Industrial electrical',
              'Advanced firefighting',
              'Health, Safety and Environment (HSE Levels 1, 2 & 3) and Roustabout',
              'NEBOSH certifications',
              'Pipe / Gas / Argon welding',
              'Structural welding',
              'Corrosion protection techniques',
              'Non-Destructive Testing (NDT)',
              'Forklift operation',
              'Rigging operation techniques',
              'Crane operation',
              'Milling operation',
              'Heavy-duty engine maintenance',
            ],
          ),
          const SizedBox(height: 20),
          const _CapacityCategory(
            title: 'Automobile Diagnostics & Maintenance Services',
            items: [
              'Car digital diagnostics and maintenance',
              'Car engine maintenance',
              'Auto electrical maintenance',
              'Auto air conditioning maintenance',
              'Auto welding',
              'Auto panel beating services',
              'Auto paint spraying services',
            ],
          ),
          const SizedBox(height: 20),
          const _CapacityCategory(
            title: 'Social & Public Event Coverages',
            items: [
              'Sound engineering, cinematography, video recording and content creation',
            ],
          ),
          const SizedBox(height: 20),
          const _CapacityCategory(
            title: 'Agric & Entrepreneurship',
            items: [
              'Cropping techniques, animal husbandry, poultry business etc.',
            ],
          ),
          const SizedBox(height: 20),
          const _CapacityCategory(
            title: 'Catering & Confectioneries Services Training',
            items: [
              'Fashion design',
              'Interior and exterior decorations',
            ],
          ),
          const SizedBox(height: 40),
          Reveal(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: Text(
                'We train and retrain young school leavers and graduates in various '
                'artisan skill-sets and software engineering professional skills for '
                'self-sustainability and development. In collaboration with our '
                'clients and partners, we empower our trained graduands and certify '
                'them with national and relevant certifications in their respective '
                'fields of training.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 36),
          const _BodyHeading(
            'The Leverage',
            'These skills enable our graduates to:',
            accent: _accent,
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 24.0;
              final columns = gridColumnsFor(constraints.maxWidth,
                  minItemWidth: 320, maxColumns: 2);
              final itemWidth =
                  gridItemWidth(constraints.maxWidth, columns, spacing: gap);
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < _leverages.length; i++)
                    SizedBox(
                      width: itemWidth,
                      child: Reveal(
                        delayMs: (i % columns) * 80,
                        child: _FeatureCard(
                          icon: _leverages[i].$1,
                          title: _leverages[i].$2,
                          description: _leverages[i].$3,
                          accent: _accent,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 36),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.bgSoft,
              borderRadius: BorderRadius.circular(AppSizing.radius),
              border: const Border(
                left: BorderSide(color: AppColors.red600, width: 5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'In our training scheme we interface and collaborate with '
                  'professional workshop operations for practical placement of '
                  'skills that require equipment we may not have.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 14),
                Text(
                  'Over the years we have trained youths for non-governmental '
                  'organisations (NGOs), companies and corporate organisations, '
                  'and government establishments.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.slate500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
          const _DetailFooterActions(),
        ],
      ),
    );
  }
}

// ===========================================================================
// 5. Capacity Building in Engineering Designs
// ===========================================================================
class EngineeringDesignsPage extends StatelessWidget {
  const EngineeringDesignsPage({super.key});

  static const _accent = Color(0xFF7C3AED);
  static const _specs = [
    (
      Icons.electrical_services_outlined,
      'Electrical Facilities Designs & Developments',
      'Domestic, commercial and industrial electrical facilities — including '
          'electrical substations/stations and transmission lines.',
    ),
    (
      Icons.tune_outlined,
      'Process Control & Instrumentation Designs',
      'Instrumentation, control and automation design for process and '
          'manufacturing environments.',
    ),
    (
      Icons.plumbing_outlined,
      'Mechanical Facilities Designs',
      'Plumbing systems, water reticulation and supply, HVAC systems, central '
          'sewage systems and advanced firefighting.',
    ),
    (
      Icons.apartment_outlined,
      'Civil / Structural Designs',
      'Domestic, commercial and industrial facilities across all building types.',
    ),
  ];

  static const _related = [
    _RelatedCard(
      Icons.bolt_outlined,
      'Electrical Installation & Construction',
      'Procure, install & commission electrical facilities.',
      '/services/electrical',
      Color(0xFF2563EB),
    ),
    _RelatedCard(
      Icons.settings_outlined,
      'Mechanical Engineering Design',
      'Design & install mechanical building facilities.',
      '/services/mechanical',
      AppColors.red600,
    ),
    _RelatedCard(
      Icons.eco_outlined,
      'Environmental Engineering Consultancy',
      'Sustainable solutions for the environment.',
      '/services/environmental',
      AppColors.green600,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _DetailScaffold(
      eyebrow: 'Capacity Building',
      title: 'In Engineering Designs',
      subtitle:
          'Training young graduands in relevant engineering fields for job '
          'placement and self-employment.',
      image: 'assets/images/hero.png',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: Text(
                'DEOPEL Engineering, with our resourceful professionals who have '
                'worked in various engineering fields, trains young graduands in '
                'relevant engineering fields for job placement and self-employment '
                'across the following specifications:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 24.0;
              final columns = gridColumnsFor(constraints.maxWidth,
                  minItemWidth: 320, maxColumns: 2);
              final itemWidth =
                  gridItemWidth(constraints.maxWidth, columns, spacing: gap);
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < _specs.length; i++)
                    SizedBox(
                      width: itemWidth,
                      child: Reveal(
                        delayMs: (i % columns) * 80,
                        child: _FeatureCard(
                          icon: _specs[i].$1,
                          title: _specs[i].$2,
                          description: _specs[i].$3,
                          accent: _accent,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 48),
          const _BodyHeading(
            'Explore',
            'Related engineering services',
            accent: _accent,
          ),
          const SizedBox(height: 24),
          const _RelatedServices(items: _related),
          const SizedBox(height: 40),
          const _DetailFooterActions(),
        ],
      ),
    );
  }
}
