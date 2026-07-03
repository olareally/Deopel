import 'package:flutter/material.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class PartnersPage extends StatelessWidget {
  const PartnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width < 720 ? 1 : (width < 1024 ? 2 : 3);
    return Column(
      children: [
        const PageBanner(
          eyebrow: 'Our Partners and Allies',
          title:
              'Collaborating with workshops, certification bodies and industry stakeholders',
          subtitle:
              'Partnerships give our trainees hands-on placement and recognised '
              'credentials beyond our own equipment.',
          image: 'assets/images/training-2.png',
        ),
        SectionPadding(
          child: ContentContainer(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const gap = 24.0;
                final cardWidth =
                    (constraints.maxWidth - gap * (columns - 1)) / columns;
                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (int i = 0; i < kPartners.length; i++)
                      SizedBox(
                        width: cardWidth,
                        child: Reveal(
                          delayMs: (i % columns) * 90,
                          child: HoverCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.navy050,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.handshake_outlined,
                                      color: AppColors.navy700),
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  kPartners[i].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontSize: 17.5),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  kPartners[i].details,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
