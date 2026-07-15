import 'package:flutter/material.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ImpactPage extends StatelessWidget {
  const ImpactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageBanner(
          eyebrow: 'Our Impact',
          title:
              'Building self-reliant professionals through training and placement',
          subtitle:
              'Our trainees go on to secure jobs, launch businesses and mentor '
              'the next generation of skilled workers.',
          image: 'assets/images/training-1.png',
        ),
        SectionPadding(
          child: ContentContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: Text(
                    'Deopel has trained youths in artisanship and engineering '
                    'software skills. Many of them have gone on to become fully '
                    'employed, start businesses, or work as workshop operators '
                    'and trainers. Through our collaborations with partner '
                    'workshops, trainees receive practical experience and '
                    'certifications that improve employability and support '
                    'entrepreneurship.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 26),
                const CheckItem(
                    'Enable trainees to become entrepreneurs and self-employed professionals.'),
                const CheckItem(
                    'Equip trainees to employ others and mentor apprentices, growing local workforces.'),
                const CheckItem(
                    'Provide practical placements and certification pathways with partner organisations.'),
                const CheckItem(
                    'Prepare trainees for roles in oil & gas, manufacturing and building industries.'),
                const SizedBox(height: 40),
                _ImpactGrid(items: kImpactItems),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.green050,
                    borderRadius: BorderRadius.circular(AppSizing.radius),
                    border: Border(
                      left: BorderSide(color: AppColors.green600, width: 5),
                    ),
                  ),
                  child: Text(
                    'These outcomes reduce unemployment and increase resilience '
                    'in the communities we serve.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.green700,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ImpactGrid extends StatelessWidget {
  const _ImpactGrid({required this.items});
  final List<ImpactItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 24.0;
        final columns = gridColumnsFor(constraints.maxWidth,
            minItemWidth: 360, maxColumns: 2);
        final cardWidth =
            gridItemWidth(constraints.maxWidth, columns, spacing: gap);
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (int i = 0; i < items.length; i++)
              SizedBox(
                width: cardWidth,
                child: Reveal(
                  delayMs: (i % columns) * 90,
                  child: HoverCard(
                    accentBar: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.navy050,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${i + 1}',
                                style: const TextStyle(
                                  color: AppColors.navy700,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                items[i].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          items[i].description,
                          style: Theme.of(context).textTheme.bodyMedium,
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
