import 'package:url_launcher/url_launcher.dart';

import '../data/site_data.dart';

/// Central place for all outbound links (tel, WhatsApp, mail, maps, web).
class Launch {
  Launch._();

  static Future<void> _open(Uri uri) async {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<void> phone() => _open(Uri(scheme: 'tel', path: SiteInfo.phone));

  static Future<void> phone2() =>
      _open(Uri(scheme: 'tel', path: SiteInfo.phone2));

  static Future<void> whatsApp([String? message]) => _open(
        Uri.parse(
          'https://wa.me/${SiteInfo.phoneDigits}'
          '${message != null ? '?text=${Uri.encodeComponent(message)}' : ''}',
        ),
      );

  static Future<void> email() =>
      _open(Uri(scheme: 'mailto', path: SiteInfo.email));

  static Future<void> website() =>
      _open(Uri.parse('https://${SiteInfo.website}'));

  static Future<void> maps() => _open(
        Uri.parse(
          'https://www.google.com/maps/search/?api=1&query='
          '${Uri.encodeComponent(SiteInfo.location)}',
        ),
      );

  /// Opens the visitor's mail client pre-filled with their inquiry.
  static Future<void> contactInquiry({
    required String name,
    required String fromEmail,
    required String message,
  }) {
    final body = 'Name: $name\nEmail: $fromEmail\n\n$message';
    return _open(
      Uri(
        scheme: 'mailto',
        path: SiteInfo.email,
        query: 'subject=${Uri.encodeComponent('Training inquiry from $name')}'
            '&body=${Uri.encodeComponent(body)}',
      ),
    );
  }
}
