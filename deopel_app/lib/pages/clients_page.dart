import 'package:flutter/material.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width < 640 ? 1 : (width < 1024 ? 2 : 3);
    return Column(
      children: [
        const PageBanner(
          eyebrow: 'Our Clients',
          title: 'Trusted by government agencies, NGOs and industry partners',
          subtitle:
              'We deliver training and capacity-building programs for public '
              'institutions, corporates and development organisations.',
          image: 'assets/images/training.png',
        ),
        SectionPadding(
          child: ContentContainer(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const gap = 20.0;
                final cardWidth =
                    (constraints.maxWidth - gap * (columns - 1)) / columns;
                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (int i = 0; i < kClients.length; i++)
                      SizedBox(
                        width: cardWidth,
                        child: Reveal(
                          delayMs: (i % columns) * 70,
                          child: HoverCard(
                            accentBar: false,
                            padding: const EdgeInsets.all(22),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  margin: const EdgeInsets.only(top: 6),
                                  decoration: const BoxDecoration(
                                    color: AppColors.red600,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    kClients[i],
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontSize: 16,
                                          height: 1.35,
                                        ),
                                  ),
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
