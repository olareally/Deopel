import 'package:flutter/material.dart';

/// Central store for all site content ported from the original Deopel React
/// site. Keeping copy in one place makes it easy to maintain.
class SiteInfo {
  SiteInfo._();

  static const String companyName = 'Deopel';
  static const String companyFull = 'Deopel Engineering Associates Limited';
  static const String tagline = 'Engineering Associates Limited';
  static const String phone = '+234 803 341 3053';
  static const String phoneDigits = '2348033413053';
  static const String phone2 = '+234 803 367 1015';
  static const String phone2Digits = '2348033671015';
  static const String email = 'info@deopelengas.com';
  static const String website = 'www.deopelengas.com';
  static const String location =
      '108 Ada George Road, Chinda Bus Stop, Mile 4, Port Harcourt, Rivers State';
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
    eyebrow: 'Oil & Gas Operations',
    title: 'Powering Nigeria’s energy sector with ',
    accent: 'skilled hands.',
    body:
        'From upstream production to downstream distribution, our trainees are '
        'prepared for careers in oil and gas operations, pipeline maintenance '
        'and refinery support — built on safety, precision and industry best practice.',
    image: 'assets/images/oil1.jpg',
  ),
  HeroSlide(
    eyebrow: 'Energy Infrastructure',
    title: 'Building the workforce behind ',
    accent: 'Nigeria’s oil & gas future.',
    body:
        'Deopel equips trainees with practical exposure to petroleum facilities, '
        'process plants and industrial equipment — giving them the confidence '
        'and competence to thrive in one of the world’s most demanding industries.',
    image: 'assets/images/oil2.webp',
  ),
  HeroSlide(
    eyebrow: 'Welding & Fabrication',
    title: 'Precision welding for ',
    accent: 'industrial excellence.',
    body:
        'Our welding and fabrication training covers arc, MIG, TIG and pipeline '
        'welding techniques — producing certified welders ready for construction, '
        'oil & gas and manufacturing projects across the region.',
    image: 'assets/images/weld1.webp',
  ),
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
  const ServiceItem(this.icon, this.title, this.description, {this.route});
  final IconData icon;
  final String title;
  final String description;
  final String? route;
}

const List<ServiceItem> kServices = [
  ServiceItem(
    Icons.architecture_outlined,
    'Engineering Design Capacity Building',
    'Electrical, process control, mechanical and civil/structural design '
        'training for job placement and self-employment.',
    route: '/capacity-building/engineering-designs',
  ),
  ServiceItem(
    Icons.handyman_outlined,
    'Building Services & Artisan Skills',
    'A full spectrum of practical training — building services & artisan '
        'skills, oil & gas industry skills, automobile diagnostics, event '
        'coverage, agriculture, entrepreneurship, catering and more.',
    route: '/capacity-building',
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
    'Various workshop owners and operators in equipment services maintenance',
    '',
  ),
];

const List<String> kClients = [
  'Rivers State Sustainable Development & Monitoring Board (RSSDA)',
  'Nigerian Content Development and Monitoring Board (NCDMB)',
  'Shell Petroleum Development Company (SPDC)',
  'Nigeria Liquefied Natural Gas (NLNG)',
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

const List<GalleryItem> kArtisanGallery = [
  GalleryItem('Bricklaying', 'assets/gallery/artisan/Bricklaying.png'),
  GalleryItem('Plumbing', 'assets/gallery/artisan/Plumbing.png'),
  GalleryItem('Welding', 'assets/gallery/artisan/Welding 1.png'),
  GalleryItem('Air Conditioning', 'assets/gallery/artisan/Air Conditioner.png'),
  GalleryItem('Tiling', 'assets/gallery/artisan/Tiling.png'),
  GalleryItem('Aluminum Work', 'assets/gallery/artisan/Aluminum.png'),
  GalleryItem('Representative/Deopel Signup', 'assets/images/training-2.png'),
  GalleryItem('Class Room', 'assets/images/training-room.png'),
  GalleryItem('Hands on teaching practical session', 'assets/images/training.png'),
];

const List<GalleryItem> kEngineeringGallery = [
  GalleryItem('Electrical Installation', 'assets/gallery/Engineering/Electrical Installation.png'),
  GalleryItem('Scaffolding', 'assets/gallery/Engineering/Scaffolding.png'),
  GalleryItem('CCTV Systems', 'assets/gallery/Engineering/CCTV.png'),
  GalleryItem('Welding', 'assets/gallery/Engineering/Welding.png'),
  GalleryItem('Air Conditioning', 'assets/gallery/Engineering/Air Conditioner 2.png'),
  GalleryItem('Aluminum Systems', 'assets/gallery/Engineering/Aluminum 2.png'),
];
