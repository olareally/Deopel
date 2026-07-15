import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final currentItems =
        _selectedTab == 0 ? kArtisanGallery : kEngineeringGallery;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tab row: Artisan Skills | Engineering
                _GalleryTabs(
                  selectedIndex: _selectedTab,
                  onSelect: (i) => setState(() => _selectedTab = i),
                ),
                const SizedBox(height: 32),
                // Gallery grid for the selected category
                LayoutBuilder(
                  key: ValueKey(_selectedTab),
                  builder: (context, constraints) {
                    const gap = 24.0;
                    final columns = gridColumnsFor(constraints.maxWidth,
                        minItemWidth: 360, maxColumns: 2);
                    final cardWidth = gridItemWidth(
                        constraints.maxWidth, columns,
                        spacing: gap);
                    return Wrap(
                      spacing: gap,
                      runSpacing: gap,
                      children: [
                        for (int i = 0; i < currentItems.length; i++)
                          SizedBox(
                            width: cardWidth,
                            child: Reveal(
                              delayMs: (i % columns) * 90,
                              child: _GalleryCard(
                                item: currentItems[i],
                                onTap: () =>
                                    _openLightbox(context, i, currentItems),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GalleryTabs extends StatelessWidget {
  const _GalleryTabs({required this.selectedIndex, required this.onSelect});

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _TabButton(
          label: 'Artisan Skills',
          selected: selectedIndex == 0,
          onTap: () => onSelect(0),
        ),
        _TabButton(
          label: 'Engineering',
          selected: selectedIndex == 1,
          onTap: () => onSelect(1),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.navy900 : AppColors.white,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected ? AppColors.navy900 : AppColors.slate300,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.red600,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  color: selected ? AppColors.white : AppColors.navy900,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _openLightbox(BuildContext context, int index, List<GalleryItem> items) {
  showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.9),
    builder: (_) => _GalleryLightbox(initialIndex: index, items: items),
  );
}

class _GalleryCard extends StatefulWidget {
  const _GalleryCard({required this.item, required this.onTap});
  final GalleryItem item;
  final VoidCallback onTap;

  @override
  State<_GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<_GalleryCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
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
                // Zoom hint that fades in on hover.
                Positioned(
                  top: 16,
                  right: 16,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _hover ? 1 : 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.zoom_out_map_rounded,
                          size: 18, color: AppColors.navy900),
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
                        style: GoogleFonts.montserrat(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ],
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

/// Full-screen image viewer with prev/next navigation.
class _GalleryLightbox extends StatefulWidget {
  const _GalleryLightbox({
    required this.initialIndex,
    required this.items,
  });
  final int initialIndex;
  final List<GalleryItem> items;

  @override
  State<_GalleryLightbox> createState() => _GalleryLightboxState();
}

class _GalleryLightboxState extends State<_GalleryLightbox> {
  late final PageController _controller =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final next = (_index + delta).clamp(0, widget.items.length - 1);
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizing.isMobile(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 48,
        vertical: isMobile ? 24 : 48,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizing.radius),
                        child: Image.asset(widget.items[i].image,
                            fit: BoxFit.contain),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.items[i].title,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Close button
          Positioned(
            top: 0,
            right: 0,
            child: _RoundIconButton(
              icon: Icons.close_rounded,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          // Prev / next
          if (_index > 0)
            Positioned(
              left: 0,
              child: _RoundIconButton(
                icon: Icons.chevron_left_rounded,
                onTap: () => _go(-1),
              ),
            ),
          if (_index < widget.items.length - 1)
            Positioned(
              right: 0,
              child: _RoundIconButton(
                icon: Icons.chevron_right_rounded,
                onTap: () => _go(1),
              ),
            ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: Colors.white24,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: AppColors.white, size: 26),
          ),
        ),
      ),
    );
  }
}
