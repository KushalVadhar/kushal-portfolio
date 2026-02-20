import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'common/glassmorphism_card.dart';

class ContactCard extends StatefulWidget {
  final bool isCompact;

  const ContactCard({super.key, this.isCompact = false});

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all fields'),
          backgroundColor: Colors.redAccent.withOpacity(0.9),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isSending = true);

    // Simulate sending delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isSending = false);
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_outline, color: Colors.white),
                const SizedBox(width: 12),
                const Text('Message delivered successfully!'),
              ],
            ),
            backgroundColor: Colors.green.withOpacity(0.9),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphismCard(
      title: 'Contact Me',
      child: widget.isCompact ? _buildCompactLayout() : _buildFullLayout(),
    );
  }

  Widget _buildFullLayout() {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isSmallMobile = constraints.maxWidth < 400;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Contact Links
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _ContactLink(
                  icon: Icons.email_rounded,
                  label: 'EMAIL',
                  value: 'kushalvadhar@gmail.com',
                  url: 'mailto:kushalvadhar@gmail.com',
                  color: Colors.redAccent.shade100,
                ),
                Divider(
                    color: Colors.white.withOpacity(0.05),
                    height: 1,
                    indent: 44),
                _ContactLink(
                  icon: Icons.link_rounded,
                  label: 'LINKEDIN',
                  value: isSmallMobile
                      ? 'linkedin.com/in/...'
                      : 'linkedin.com/in/kushal-vadhar',
                  url: 'https://linkedin.com/in/kushal-vadhar',
                  color: Colors.blueAccent.shade100,
                ),
                Divider(
                    color: Colors.white.withOpacity(0.05),
                    height: 1,
                    indent: 44),
                _ContactLink(
                  icon: Icons.code_rounded,
                  label: 'GITHUB',
                  value: 'github.com/KushalVadhar',
                  url: 'https://github.com/KushalVadhar',
                  color: Colors.white70,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Quick Message Form
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              'SEND A QUICK MESSAGE',
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildInputField(
              'Your Name', Icons.person_outline_rounded, _nameController),
          const SizedBox(height: 10),
          _buildInputField(
              'Your Email', Icons.alternate_email_rounded, _emailController),
          const SizedBox(height: 10),
          _buildInputField(
              'Message', Icons.chat_bubble_outline_rounded, _messageController,
              maxLines: 4),
          const SizedBox(height: 16),
          _buildSendButton(),
        ],
      );
    });
  }

  Widget _buildCompactLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _SocialIcon(
              icon: Icons.email_outlined,
              color: Colors.red.shade300,
              url: 'mailto:kushalvadhar@gmail.com',
            ),
            _SocialIcon(
              icon: Icons.link,
              color: Colors.blue.shade400,
              url: 'https://linkedin.com/in/kushal-vadhar',
            ),
            const _SocialIcon(
              icon: Icons.code,
              color: Colors.white,
              url: 'https://github.com/KushalVadhar',
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Tap to connect!',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(
      String hint, IconData icon, TextEditingController controller,
      {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white24, size: 18),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.2),
            fontSize: 13,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _isSending ? null : _handleSend,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isSending
                  ? [Colors.grey.shade700, Colors.grey.shade800]
                  : [const Color(0xFF007AFF), const Color(0xFF0051AF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              if (!_isSending)
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Center(
            child: _isSending
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Deliver Message',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _ContactLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String url;
  final Color color;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
    required this.color,
  });

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _isHovered = false;

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback - try to launch anyway
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e) {
        debugPrint('Could not launch ${widget.url}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchURL,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color:
                _isHovered ? widget.color.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: widget.color, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      widget.value,
                      style: TextStyle(
                        color: _isHovered
                            ? widget.color
                            : Colors.white.withOpacity(0.9),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withOpacity(0.3),
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String url;

  const _SocialIcon({
    required this.icon,
    required this.color,
    required this.url,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e) {
        debugPrint('Could not launch ${widget.url}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchURL,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withOpacity(0.2)
                : Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered
                  ? widget.color.withOpacity(0.5)
                  : Colors.white.withOpacity(0.1),
            ),
          ),
          child: Icon(
            widget.icon,
            color: widget.color,
            size: 24,
          ),
        ),
      ),
    );
  }
}
