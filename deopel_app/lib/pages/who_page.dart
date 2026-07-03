import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class WhoPage extends StatelessWidget {
  const WhoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageBanner(
          eyebrow: 'Who We Are',
          title:
              'A capacity-building partner for youth and professionals',
          subtitle:
              'Deopel Engineering trains and retrains young school leavers and '
              'graduates in artisan and engineering skills for self-sustainability.',
          image: 'assets/images/training-1.png',
        ),
        SectionPadding(
          child: ContentContainer(
            child: ResponsiveRow(
              spacing: 44,
              children: [
                Flexed(
                  6,
                  Reveal(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Eyebrow('Our Story'),
                        const SizedBox(height: 14),
                        Text(
                          'Empowering graduates with recognised skills and '
                          'real placement opportunities.',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontSize: 28),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'We train and retrain young school leavers and '
                          'graduates in artisan skills and engineering software '
                          'professional skills for self-sustainability and '
                          'development.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'In collaboration with clients and partners, we '
                          'empower graduands with nationally recognized '
                          'certificates and practical placement opportunities.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 26),
                        const CheckItem(
                            'Training that supports entrepreneurship and self-employment.'),
                        const CheckItem(
                            'Practical workshop placement for skills beyond our own equipment.'),
                        const CheckItem(
                            'Programs for NGOs, government, corporate organizations and private clients.'),
                        const SizedBox(height: 28),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: BrandButton(
                            label: 'See our impact',
                            variant: BrandButtonVariant.dark,
                            onPressed: () => context.go('/impact'),
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
                        aspectRatio: 4 / 4.4,
                        child: Image.asset('assets/images/training-2.png',
                            fit: BoxFit.cover),
                      ),
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
