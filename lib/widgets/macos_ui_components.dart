import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MacOsSearchOverlay extends StatefulWidget {
  final VoidCallback onDismiss;

  const MacOsSearchOverlay({super.key, required this.onDismiss});

  @override
  State<MacOsSearchOverlay> createState() => _MacOsSearchOverlayState();
}

class _MacOsSearchOverlayState extends State<MacOsSearchOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onDismiss,
      child: Container(
        color: Colors.black.withOpacity(0.1),
        child: FadeTransition(
          opacity: _animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 1.05, end: 1.0).animate(_animation),
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 650,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D1D1F).withOpacity(0.85),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 0.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(CupertinoIcons.search,
                            color: Colors.white, size: 28),
                      ),
                      const Expanded(
                        child: TextField(
                          autofocus: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'San Francisco',
                          ),
                          decoration: InputDecoration(
                            hintText: 'Spotlight Search',
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          '⌘ K',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.3),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MacOsMenuOverlayContainer extends StatelessWidget {
  final Offset offset;
  final Widget menu;
  final VoidCallback onDismiss;

  const MacOsMenuOverlayContainer({
    super.key,
    required this.offset,
    required this.menu,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onDismiss,
          child: Container(color: Colors.transparent),
        ),
        Positioned(
          left: offset.dx - 200, // Slightly more space for wider menus
          top: offset.dy + 10,
          child: Material(
            color: Colors.transparent,
            child: menu,
          ),
        ),
      ],
    );
  }
}

class MacOsWiFiMenu extends StatefulWidget {
  const MacOsWiFiMenu({super.key});

  @override
  State<MacOsWiFiMenu> createState() => _MacOsWiFiMenuState();
}

class _MacOsWiFiMenuState extends State<MacOsWiFiMenu> {
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  void _startScan() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _isScanning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1F).withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MacOsMenuTitle(title: 'Wi-Fi'),
              MacOsNativeSwitch(value: true, onChanged: (_) {}),
            ],
          ),
          const Divider(color: Colors.white10),
          if (_isScanning)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text('Searching for networks...',
                        style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ),
            )
          else ...[
            const MacOsMenuActionItem(
              icon: CupertinoIcons.wifi,
              label: 'Kushal_5G',
              color: Colors.blueAccent,
              trailing: Icon(CupertinoIcons.lock_fill,
                  size: 12, color: Colors.white38),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                'Other Networks',
                style: TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ),
            const MacOsMenuActionItem(
                icon: CupertinoIcons.wifi,
                label: 'Interlink_Office',
                trailing: Icon(CupertinoIcons.lock_fill,
                    size: 12, color: Colors.white38)),
            const MacOsMenuActionItem(
                icon: CupertinoIcons.wifi,
                label: 'Starbucks_Free',
                trailing: Icon(CupertinoIcons.lock_open_fill,
                    size: 12, color: Colors.white38)),
          ],
          const Divider(color: Colors.white10),
          const MacOsMenuActionItem(icon: null, label: 'Wi-Fi Settings...'),
        ],
      ),
    );
  }
}

class MacOsProfileMenu extends StatelessWidget {
  const MacOsProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1F).withOpacity(0.98),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.blueAccent.withOpacity(0.5), width: 2),
                  image: const DecorationImage(
                    image: NetworkImage('https://github.com/KushalVadhar.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kushal Vadhar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'San Francisco',
                      ),
                    ),
                    const SizedBox(height: 4),
                    const MacOsStatusBadge(label: 'Open for Roles')
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(
                            duration: 2000.ms,
                            color: Colors.greenAccent.withOpacity(0.2)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Control Grid
          Row(
            children: [
              MacOsControlTile(
                icon: FontAwesomeIcons.github,
                label: 'GitHub',
                isActive: true,
                onTap: () => _launchURL('https://github.com/KushalVadhar'),
              ),
              const SizedBox(width: 12),
              MacOsControlTile(
                icon: CupertinoIcons.link,
                label: 'LinkedIn',
                isActive: true,
                onTap: () =>
                    _launchURL('https://linkedin.com/in/kushal-vadhar'),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Quick Links
          const Divider(color: Colors.white10, height: 24),
          const Text(
            'QUICK ACCESS',
            style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2),
          ),
          const SizedBox(height: 12),
          MacOsMenuActionItem(
            icon: CupertinoIcons.cloud_download,
            label: 'Download CV',
            color: Colors.greenAccent,
            onTap: () => _launchURL(
                'https://github.com/KushalVadhar'), // Placeholder for CV
          ),
          MacOsMenuActionItem(
              icon: CupertinoIcons.mail,
              label: 'Contact Me',
              color: Colors.orangeAccent,
              onTap: () => _launchURL('mailto:kushalvadhar@gmail.com')),

          // Mock Metrics
          const Divider(color: Colors.white10, height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MacOsMetricItem(
                  label: 'Velocity', value: '98%', color: Colors.blue),
              MacOsMetricItem(
                  label: 'Battery', value: '100%', color: Colors.green),
              MacOsMetricItem(
                  label: 'Focus', value: 'Zen', color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class MacOsMenuTitle extends StatelessWidget {
  final String title;
  const MacOsMenuTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class MacOsMenuActionItem extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Color? color;
  final Widget? trailing;
  final VoidCallback? onTap;

  const MacOsMenuActionItem({
    super.key,
    this.icon,
    required this.label,
    this.color,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: color ?? Colors.white, size: 16),
                const SizedBox(width: 10),
              ] else if (icon == null)
                const SizedBox(width: 26),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}

class MacOsStatusBadge extends StatelessWidget {
  final String label;
  const MacOsStatusBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.greenAccent,
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class MacOsControlTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const MacOsControlTile({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(isActive ? 0.15 : 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon,
                  color: isActive ? Colors.blueAccent : Colors.white54,
                  size: 20),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MacOsMetricItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const MacOsMetricItem({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                color: color, fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(color: Colors.white38, fontSize: 10)),
      ],
    );
  }
}

class MacOsNativeSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const MacOsNativeSwitch(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 36,
        height: 20,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? Colors.blueAccent : Colors.white24,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

class MacOsStatusIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const MacOsStatusIcon({super.key, required this.icon, this.onTap});

  @override
  State<MacOsStatusIcon> createState() => _MacOsStatusIconState();
}

class _MacOsStatusIconState extends State<MacOsStatusIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Icon(
          widget.icon,
          color: _isHovered ? Colors.white : Colors.white.withOpacity(0.8),
          size: 18,
        ),
      ),
    );
  }
}
