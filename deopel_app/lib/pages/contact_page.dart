import 'package:flutter/material.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import '../utils/launchers.dart';
import '../widgets/common.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageBanner(
          eyebrow: 'Get in Touch',
          title: 'Ready to start your training journey?',
          subtitle:
              'Tell us the training you need and we will match you to the right '
              'program, partner workshop and certification pathway.',
          image: 'assets/images/training-2.png',
        ),
        SectionPadding(
          child: ContentContainer(
            child: const ResponsiveRow(
              children: [
                Flexed(5, _ContactDetails()),
                Flexed(7, _ContactForm()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactDetails extends StatelessWidget {
  const _ContactDetails();

  @override
  Widget build(BuildContext context) {
    return Reveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('Contact details'),
          const SizedBox(height: 14),
          Text(
            'Let\'s talk about your training goals.',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 24),
          _ContactRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: SiteInfo.phone,
            onTap: Launch.phone,
          ),
          _ContactRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: SiteInfo.phone2,
            onTap: Launch.phone2,
          ),
          _ContactRow(
            icon: Icons.chat_outlined,
            label: 'WhatsApp',
            value: SiteInfo.phone,
            onTap: () => Launch.whatsApp(),
          ),
          _ContactRow(
            icon: Icons.mail_outline,
            label: 'Email',
            value: SiteInfo.email,
            onTap: Launch.email,
          ),
          _ContactRow(
            icon: Icons.language_outlined,
            label: 'Website',
            value: SiteInfo.website,
            onTap: Launch.website,
          ),
          _ContactRow(
            icon: Icons.location_on_outlined,
            label: 'Office address',
            value: SiteInfo.location,
            onTap: Launch.maps,
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatefulWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  State<_ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<_ContactRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: _hover ? AppColors.red600 : AppColors.red050,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.icon,
                  color: _hover ? AppColors.white : AppColors.red600,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.slate500,
                        fontSize: 11.5,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      style: TextStyle(
                        color: _hover ? AppColors.red600 : AppColors.navy900,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.5,
                        height: 1.4,
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

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Launch.contactInquiry(
        name: _name.text.trim(),
        fromEmail: _email.text.trim(),
        message: _message.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.green600,
          content: Text(
            'Opening your email app to send the inquiry…',
          ),
        ),
      );
      _name.clear();
      _email.clear();
      _message.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Reveal(
      delayMs: 120,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizing.radiusLg),
          border: Border.all(color: AppColors.slate200),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy900.withValues(alpha: 0.06),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send a message',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _field(
                controller: _name,
                label: 'Name',
                hint: 'Your name',
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              _field(
                controller: _email,
                label: 'Email',
                hint: 'you@example.com',
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter your email';
                  if (!v.contains('@')) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _field(
                controller: _message,
                label: 'Message',
                hint: 'Tell us what training you need',
                maxLines: 4,
                validator: (v) => (v == null || v.isEmpty)
                    ? 'Please enter a message'
                    : null,
              ),
              const SizedBox(height: 24),
              BrandButton(label: 'Send Inquiry', onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.navy900,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppColors.slate100,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.slate200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.navy700, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.red600),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.red600, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
