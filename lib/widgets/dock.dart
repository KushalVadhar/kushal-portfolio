import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';

class Dock extends StatefulWidget {
  final Function(String) onAppTap;
  final bool isCompact;

  const Dock({super.key, required this.onAppTap, this.isCompact = false});

  @override
  State<Dock> createState() => _DockState();
}

class _DockState extends State<Dock> {
  Offset? _mousePosition;

  // Fully Custom "Premium Code-Based" Icons
  final List<DockItemData> _items = [
    DockItemData(
      appName: "About", // Was Finder
      icon: CupertinoIcons.person_crop_circle, // User profile
      iconColor: Colors.white,
      gradientColors: [
        const Color(0xFF00C6FB),
        const Color(0xFF005BEA)
      ], // Blue
    ),
    DockItemData(
      appName: "Projects",
      icon: CupertinoIcons.folder_solid, // Folder
      iconColor: Colors.white,
      gradientColors: [
        const Color(0xFFFF9966),
        const Color(0xFFFF5E62)
      ], // Orange
    ),
    DockItemData(
      appName: "Skills",
      icon: CupertinoIcons.wrench_fill, // Tools/Skills
      iconColor: Colors.white,
      gradientColors: [
        const Color(0xFF11998E),
        const Color(0xFF38EF7D)
      ], // Green
    ),
    DockItemData(
      appName: "Contact", // Was Messages
      icon: CupertinoIcons.mail_solid, // Mail
      iconColor: Colors.white,
      gradientColors: [
        const Color(0xFF56CCF2),
        const Color(0xFF2F80ED)
      ], // Light Blue
    ),
    DockItemData(
      appName: "Terminal",
      icon: Icons.terminal, // Prompt: >_
      iconColor: Colors.white,
      gradientColors: [
        const Color(0xFF434343),
        const Color(0xFF000000)
      ], // Dark Grey/Black
    ),
    DockItemData(
      appName: "Settings",
      icon: CupertinoIcons.settings_solid, // Gear
      iconColor: Colors.grey.shade300,
      gradientColors: [
        const Color(0xFF8E8E93),
        const Color(0xFF4A4A4A)
      ], // Grey
    ),
  ];

  List<DockItemData> get _visibleItems => _items;

  @override
  Widget build(BuildContext context) {
    final baseHeight = widget.isCompact ? 58.0 : 70.0;
    final basePadding = widget.isCompact
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 5)
        : const EdgeInsets.symmetric(horizontal: 12, vertical: 6);

    return Center(
      child: MouseRegion(
        onHover: (event) {
          setState(() {
            _mousePosition = event.localPosition;
          });
        },
        onExit: (_) {
          setState(() {
            _mousePosition = null;
          });
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            // Performance Fix: Removed BackdropFilter
            child: Container(
              height: baseHeight,
              constraints: BoxConstraints(maxHeight: baseHeight),
              padding: basePadding,
              decoration: BoxDecoration(
                // Dock Dark Background
                color: const Color(0xFF1C1C1E)
                    .withOpacity(0.85), // High opacity dark
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < _visibleItems.length; i++) ...[
                    _DockItem(
                      key: ValueKey(i),
                      data: _visibleItems[i],
                      mousePosition: _mousePosition,
                      index: i,
                      onTap: widget.onAppTap,
                      isCompact: widget.isCompact,
                    ),
                    if (i < _visibleItems.length - 1)
                      SizedBox(width: widget.isCompact ? 6 : 8),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DockItemData {
  final String appName;
  final IconData icon;
  final Color iconColor;
  final List<Color> gradientColors;

  DockItemData({
    required this.appName,
    required this.icon,
    required this.iconColor,
    required this.gradientColors,
  });
}

class _DockItem extends StatefulWidget {
  final DockItemData data;
  final Offset? mousePosition;
  final int index;
  final Function(String) onTap;
  final bool isCompact;

  const _DockItem({
    super.key,
    required this.data,
    required this.mousePosition,
    required this.index,
    required this.onTap,
    this.isCompact = false,
  });

  @override
  State<_DockItem> createState() => _DockItemState();
}

class _DockItemState extends State<_DockItem>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _bounceAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  double _calculateScale() {
    return 1.0;
  }

  double _calculateElevation() {
    return 0.0;
  }

  Widget _buildIcon(double scale) {
    final size = widget.isCompact ? 45.0 : 55.0;
    final boxSize = size * scale;
    final iconSize = boxSize * 0.65;

    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.data.gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(boxSize * 0.22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8 * scale,
            offset: Offset(0, 3 * scale),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      child: Center(
        child: Icon(
          widget.data.icon,
          size: iconSize,
          color: widget.data.iconColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scale = _calculateScale();
    final elevation = _calculateElevation();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _isPressed = true);
          _bounceController.forward();
        },
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _bounceController.reverse();
          widget.onTap(widget.data.appName);
        },
        onTapCancel: () {
          setState(() => _isPressed = false);
          _bounceController.reverse();
        },
        child: AnimatedBuilder(
          animation: _bounceController,
          builder: (context, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              transform: Matrix4.identity()
                ..translate(0.0, -elevation)
                ..scale(_isPressed ? _bounceAnimation.value : 1.0),
              child: Tooltip(
                message: widget.data.appName,
                verticalOffset: -70,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: _buildIcon(scale),
              ),
            );
          },
        ),
      ),
    );
  }
}
