import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class MissionPage extends StatelessWidget {
  const MissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageBanner(
          eyebrow: 'Mission Statement / Goal',
          title: 'Our mission, vision and commitment to quality',
          subtitle:
              'Deopel Engineering Associates is driven by a commitment to '
              'excellence in engineering, training and total quality management.',
          image: 'assets/images/training-room.png',
        ),
        SectionPadding(
          child: ContentContainer(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Reveal(
                      child: _HighlightBox(
                        accent: AppColors.red600,
                        label: 'Mission & Vision',
                        child: Text(
                          'DEOPEL ENGINEERING ASSOCIATES mission and vision is '
                          'to be the global giant in Engineering, Procurement '
                          'and Project Management in the Oil & Gas industry and '
                          'in all aspects of engineering development.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.ink, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Eyebrow('Quality Assurance / Quality Control'),
                    const SizedBox(height: 12),
                    Text(
                      'Philosophy and Policy Statement',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 22),
                    Reveal(
                      delayMs: 100,
                      child: _HighlightBox(
                        accent: AppColors.green600,
                        label: 'Quality Policy',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DEOPEL ENGINEERING ASSOCIATES has a commitment to '
                              'total quality through the implementation of a '
                              'Quality Management System involving all levels of '
                              'management and every employee focusing on '
                              'continuous improvement. Our main focus is our '
                              "clients' satisfaction and continuous improvement "
                              'through the involvement of all employees at all '
                              'levels.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'It is the policy and philosophy of DEOPEL '
                              'ENGINEERING ASSOCIATES to implement all aspects of '
                              'the EN ISO 9001 series that relate to consulting '
                              'engineering firms. These are continually '
                              'implemented through various quality management '
                              'practices.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'These statements reflect Deopel\'s commitment to quality, '
                      'continual improvement, and the delivery of dependable '
                      'engineering and training services.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.slate500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HighlightBox extends StatelessWidget {
  const _HighlightBox({
    required this.child,
    required this.accent,
    required this.label,
  });
  final Widget child;
  final Color accent;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.bgSoft,
        borderRadius: BorderRadius.circular(AppSizing.radius),
        border: Border(left: BorderSide(color: accent, width: 5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
