import 'package:flutter/material.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width < 720 ? 1 : 2;
    return Column(
      children: [
        const PageBanner(
          eyebrow: 'Training Gallery',
          title: 'See our training environments in action',
          subtitle:
              'A look at the workshops, practical labs and hands-on sessions '
              'where our trainees build real skills.',
          image: 'assets/images/training-room.png',
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
                    for (int i = 0; i < kGallery.length; i++)
                      SizedBox(
                        width: cardWidth,
                        child: Reveal(
                          delayMs: (i % columns) * 90,
                          child: _GalleryCard(item: kGallery[i]),
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

class _GalleryCard extends StatefulWidget {
  const _GalleryCard({required this.item});
  final GalleryItem item;

  @override
  State<_GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<_GalleryCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizing.radius),
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 400),
                scale: _hover ? 1.06 : 1,
                child: Image.asset(widget.item.image, fit: BoxFit.cover),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        AppColors.navy900.withValues(alpha: 0.85),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 18,
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 22,
                      decoration: BoxDecoration(
                        color: AppColors.red600,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.item.title,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        fontFamily: 'SpaceGrotesk',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
