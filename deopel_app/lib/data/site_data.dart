import 'package:flutter/material.dart';

/// Central store for all site content ported from the original Deopel React
/// site. Keeping copy in one place makes it easy to maintain.
class SiteInfo {
  SiteInfo._();

  static const String companyName = 'Deopel';
  static const String companyFull = 'Deopel Engineering Associates Limited';
  static const String tagline = 'Engineering Associates Limited';
  static const String phone = '+234 800 123 4567';
  static const String email = 'info@deopelengineering.com';
  static const String location = 'Lagos, Nigeria';
  static const String logoAsset = 'assets/images/deopel-logo.png';
}

class NavItem {
  const NavItem(this.label, this.route, {this.children = const []});
  final String label;
  final String route;
  final List<NavItem> children;
}

const List<NavItem> kNavItems = [
  NavItem('Home', '/'),
  NavItem('Who We Are', '/about-us', children: [
    NavItem('About Us', '/about-us'),
    NavItem('Mission', '/mission'),
    NavItem('Our Impact', '/impact'),
  ]),
  NavItem('What We Do', '/what'),
  NavItem('Partners', '/partners'),
  NavItem('Clients', '/clients'),
  NavItem('Gallery', '/gallery'),
  NavItem('Contact', '/contact'),
];

class HeroSlide {
  const HeroSlide({
    required this.eyebrow,
    required this.title,
    required this.accent,
    required this.body,
    required this.image,
  });
  final String eyebrow;
  final String title;
  final String accent;
  final String body;
  final String image;
}

const List<HeroSlide> kHeroSlides = [
  HeroSlide(
    eyebrow: 'Capacity Building',
    title: 'Training young talent for artisanship, engineering and ',
    accent: 'professional success.',
    body:
        'Deopel Engineering Associates Limited empowers school leavers, graduates '
        'and professionals through practical training, certification support and '
        'placement collaborations across engineering and artisan skills.',
    image: 'assets/images/training-room.png',
  ),
  HeroSlide(
    eyebrow: 'Artisan & Building Skills',
    title: 'Hands-on skills that build ',
    accent: 'self-reliant careers.',
    body:
        'Electrical wiring, plumbing, welding, refrigeration and construction '
        'finishing — practical training delivered with partner workshops and '
        'recognised credentials.',
    image: 'assets/images/training-1.png',
  ),
  HeroSlide(
    eyebrow: 'Oil, Gas & Industry',
    title: 'Preparing trainees for ',
    accent: 'industry readiness.',
    body:
        'Process control, instrumentation, HSE, NDT, welding and heavy-duty '
        'maintenance — skills that make our graduates employable across sectors.',
    image: 'assets/images/training-2.png',
  ),
];

class Stat {
  const Stat(this.value, this.label);
  final String value;
  final String label;
}

const List<Stat> kStats = [
  Stat('500+', 'Youths trained'),
  Stat('6', 'Skill programs'),
  Stat('15+', 'Partner workshops'),
  Stat('100%', 'Practical focus'),
];

class ServiceItem {
  const ServiceItem(this.icon, this.title, this.description);
  final IconData icon;
  final String title;
  final String description;
}

const List<ServiceItem> kServices = [
  ServiceItem(
    Icons.handyman_outlined,
    'Building Services & Artisan Skills',
    'Electrical wiring, plumbing, refrigeration, welding, painting, tiling, '
        'scaffolding and construction finishing skills for domestic and industrial '
        'facilities.',
  ),
  ServiceItem(
    Icons.oil_barrel_outlined,
    'Oil & Gas Industry Skills',
    'Process control, instrumentation, industrial electrical, firefighting, HSE, '
        'welding, NDT, crane and forklift operation, and heavy-duty maintenance.',
  ),
  ServiceItem(
    Icons.directions_car_outlined,
    'Automobile Diagnostics & Maintenance',
    'Car diagnostics, engine maintenance, auto electrical systems, air '
        'conditioning, welding, panel beating and paint spraying.',
  ),
  ServiceItem(
    Icons.architecture_outlined,
    'Engineering Design Capacity Building',
    'Electrical, process control, mechanical and civil/structural design '
        'training for job placement and self-employment.',
  ),
  ServiceItem(
    Icons.videocam_outlined,
    'Social & Event Coverage',
    'Sound engineering, cinematography, video recording and content creation '
        'training for public and corporate events.',
  ),
  ServiceItem(
    Icons.agriculture_outlined,
    'Agriculture & Entrepreneurship',
    'Cropping, animal husbandry, poultry, catering, confectionery, fashion '
        'design and interior/exterior decoration training for sustainable businesses.',
  ),
];

class ImpactItem {
  const ImpactItem(this.title, this.description);
  final String title;
  final String description;
}

const List<ImpactItem> kImpactItems = [
  ImpactItem(
    'Trained & Employed',
    'Many of our trainees have gone on to secure full-time employment in '
        'industry and service roles.',
  ),
  ImpactItem(
    'Entrepreneurship & Self-Employment',
    'Graduates start businesses, become independent service providers and '
        'create jobs by taking on apprentices.',
  ),
  ImpactItem(
    'Practical Placement',
    'We partner with professional workshops and industry partners to provide '
        'hands-on placement where specialised equipment is needed.',
  ),
  ImpactItem(
    'Industry Readiness',
    'Trainees gain skills that make them employable in oil & gas, process '
        'manufacturing, building and construction, and public sector projects.',
  ),
];

class PartnerItem {
  const PartnerItem(this.name, this.details);
  final String name;
  final String details;
}

const List<PartnerItem> kPartners = [
  PartnerItem(
    'Advance Fabrication Ltd.',
    '#280 Trans Amadi Road, by Nipost Building',
  ),
  PartnerItem(
    'Bie – Usha (W/A) Ltd.',
    'Plot 201B PHC/Aba Express Road, Rumuola Junction, P.H.',
  ),
  PartnerItem(
    'Globspec Engineering and Trading Ltd.',
    'No. 52 Igboukwu Street, D-line, P.H.',
  ),
  PartnerItem(
    'Professional Workshop Partners',
    'Local workshops providing practical placements and hands-on training.',
  ),
  PartnerItem(
    'Certification Bodies',
    'National and industry certification partners for training credentials.',
  ),
];

const List<String> kClients = [
  'Niger Delta Development Corporation (NDDC)',
  'Rivers State Ministry of Power',
  'Rivers State Sustainable Development & Monitoring Board (RSSDA)',
  'Nigerian Content Development and Monitoring Board (NCDMB)',
  'Shell Petroleum Development Company (SPDC)',
  'Nigeria Liquefied Natural Gas (NLNG)',
  'Rivers State Ministry of Works',
  'Rivers State Ministry of Employment Generation and Empowerment',
  'Rivers State Ministry of Youth Development',
  'Local Government Councils',
  'Non-Governmental Organizations (NGOs)',
  'Corporate Organisations and Private Sector Partners',
];

class GalleryItem {
  const GalleryItem(this.title, this.image);
  final String title;
  final String image;
}

const List<GalleryItem> kGallery = [
  GalleryItem('Workshop sessions', 'assets/images/training-1.png'),
  GalleryItem('Technical presentations', 'assets/images/training-2.png'),
  GalleryItem('Training environment', 'assets/images/training-room.png'),
  GalleryItem('Hands-on practical labs', 'assets/images/training.png'),
];
