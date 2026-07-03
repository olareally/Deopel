import 'package:flutter/material.dart';
import '../data/site_data.dart';
import '../widgets/common.dart';
import 'home_page.dart' show ServicesGrid;

class WhatPage extends StatelessWidget {
  const WhatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageBanner(
          eyebrow: 'What We Do',
          title:
              'Practical capacity building across artisans, engineering and industry',
          subtitle:
              'Six focused training tracks that prepare youth and professionals '
              'for employment, self-employment and industry readiness.',
          image: 'assets/images/training.png',
        ),
        SectionPadding(
          child: ContentContainer(
            child: ServicesGrid(services: kServices),
          ),
        ),
      ],
    );
  }
}
