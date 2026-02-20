import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import '../core/utils/file_downloader.dart';
import '../core/constants/app_constants.dart';
import 'macos_ui_components.dart';

/// Responsive top bar that adapts to different screen sizes
class ResponsiveTopBar extends StatefulWidget {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onSearchTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  const ResponsiveTopBar({
    super.key,
    this.onMenuPressed,
    this.onSearchTap,
    this.onProjectsTap,
    this.onContactTap,
  });

  @override
  State<ResponsiveTopBar> createState() => _ResponsiveTopBarState();
}

class _ResponsiveTopBarState extends State<ResponsiveTopBar> {
  String _dateString = '';
  String _timeString = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final weekday = weekdays[now.weekday - 1];
    final month = months[now.month - 1];
    final day = now.day;

    final hour =
        now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';

    if (mounted) {
      setState(() {
        _dateString = '$weekday $month $day';
        _timeString = '$hour:$minute $period';
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri);
  }

  void _showSearchOverlay() {
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => MacOsSearchOverlay(
        onDismiss: () => overlayEntry.remove(),
      ),
    );
    Overlay.of(context).insert(overlayEntry);
  }

  void _showMenuOverlay(Offset offset, Widget menu) {
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => MacOsMenuOverlayContainer(
        offset: offset,
        menu: menu,
        onDismiss: () => overlayEntry.remove(),
      ),
    );
    Overlay.of(context).insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;
        final isTablet = constraints.maxWidth > 600;

        if (isDesktop) {
          return _buildDesktopBar();
        } else if (isTablet) {
          return _buildTabletBar();
        } else {
          return _buildMobileBar();
        }
      },
    );
  }

  Widget _buildDesktopBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 50,
        width: 800,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: _barDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Logo + Menus
            Row(
              children: [
                const Icon(FontAwesomeIcons.code,
                    color: Colors.blueAccent, size: 16),
                const SizedBox(width: 8),
                const Text(
                  'Portfolio',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 30),
                _TopBarItem(
                  label: "Projects",
                  onTap: widget.onProjectsTap,
                ),
                const SizedBox(width: 20),
                _TopBarItem(
                  label: "Contact",
                  onTap: widget.onContactTap,
                ),
                const SizedBox(width: 20),
                _TopBarItem(
                  label: "Resume",
                  onTap: () => FileDownloader.downloadFile(
                      AppConstants.resumeUrl,
                      filename: 'Kushal_Vadhar_Resume.pdf'),
                ),
              ],
            ),
            // Right: Status Icons + Date/Time
            Row(
              children: [
                MacOsStatusIcon(
                  icon: CupertinoIcons.search,
                  onTap: () {
                    if (widget.onSearchTap != null) {
                      widget.onSearchTap!();
                    } else {
                      _showSearchOverlay();
                    }
                  },
                ),
                const SizedBox(width: 20),
                Builder(builder: (context) {
                  return MacOsStatusIcon(
                    icon: CupertinoIcons.wifi,
                    onTap: () {
                      final RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                      final offset = renderBox.localToGlobal(Offset.zero);
                      _showMenuOverlay(
                          offset + const Offset(0, 40), const MacOsWiFiMenu());
                    },
                  );
                }),
                const SizedBox(width: 20),
                Builder(builder: (context) {
                  return MacOsStatusIcon(
                    icon: CupertinoIcons.person_circle,
                    onTap: () {
                      final RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                      final offset = renderBox.localToGlobal(Offset.zero);
                      _showMenuOverlay(offset + const Offset(0, 40),
                          const MacOsProfileMenu());
                    },
                  );
                }),
                const SizedBox(width: 24),
                Text(
                  "$_dateString  $_timeString",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 45,
        width: 500,
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: _barDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(FontAwesomeIcons.code,
                color: Colors.blueAccent, size: 16),
            Row(
              children: [
                const Icon(CupertinoIcons.wifi, color: Colors.white, size: 16),
                const SizedBox(width: 12),
                Text(
                  _timeString,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 35,
        width: 150,
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF000000).withOpacity(0.85),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            _timeString,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _barDecoration() {
    return BoxDecoration(
      color: const Color(0xFF1D1D1F).withOpacity(0.95),
      borderRadius: BorderRadius.circular(40),
      border: Border.all(
        color: Colors.white.withOpacity(0.1),
        width: 0.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}

class _TopBarItem extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  _TopBarItem({required this.label, this.onTap});

  @override
  State<_TopBarItem> createState() => _TopBarItemState();
}

class _TopBarItemState extends State<_TopBarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: TextStyle(
            color: _isHovered ? Colors.white : Colors.white.withOpacity(0.9),
            fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
