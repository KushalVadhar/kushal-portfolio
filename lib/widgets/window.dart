import 'package:flutter/material.dart';

class Window extends StatefulWidget {
  final String title;
  final Widget child;
  final Offset initialPosition;
  final Size initialSize;
  final VoidCallback? onClose;

  const Window({
    super.key,
    required this.title,
    required this.child,
    this.initialPosition = const Offset(100, 100),
    this.initialSize = const Size(600, 400),
    this.onClose,
  });

  @override
  State<Window> createState() => _WindowState();
}

class _WindowState extends State<Window> with SingleTickerProviderStateMixin {
  late Offset position;
  late Size size;
  bool _isDragging = false;
  late AnimationController _appearController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    position = widget.initialPosition;
    size = widget.initialSize;

    _appearController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _appearController, curve: Curves.easeOutBack),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _appearController, curve: Curves.easeOut),
    );

    _appearController.forward();
  }

  @override
  void dispose() {
    _appearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: AnimatedBuilder(
        animation: _appearController,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E2E2E),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(_isDragging ? 0.7 : 0.5),
                      blurRadius: _isDragging ? 50 : 40,
                      spreadRadius: _isDragging ? 5 : 0,
                      offset: Offset(0, _isDragging ? 25 : 20),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(_isDragging ? 0.25 : 0.15),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    // Title Bar with Drag Logic
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanStart: (_) => setState(() => _isDragging = true),
                      onPanUpdate: (details) {
                        setState(() {
                          position += details.delta;
                        });
                      },
                      onPanEnd: (_) => setState(() => _isDragging = false),
                      child: _TitleBar(
                        title: widget.title,
                        onClose: widget.onClose,
                        isDragging: _isDragging,
                      ),
                    ),
                    // Content
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(bottom: Radius.circular(10)),
                        child: widget.child,
                      ),
                    ),
                  ],
                ),
              ),
                ),
            );
        },
      ),
    );
  }
}

class _TitleBar extends StatelessWidget {
  final String title;
  final VoidCallback? onClose;
  final bool isDragging;

  const _TitleBar({
    required this.title,
    required this.onClose,
    required this.isDragging,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: isDragging ? const Color(0xFF454545) : const Color(0xFF3C3C3C),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        border:
            const Border(bottom: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Row(
        children: [
          _TrafficLight(color: const Color(0xFFFF5F57), onTap: onClose),
          const SizedBox(width: 8),
          const _TrafficLight(color: Color(0xFFFEBC2E), onTap: null),
          const SizedBox(width: 8),
          const _TrafficLight(color: Color(0xFF28C840), onTap: null),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFD0D0D0),
                  fontFamily: '.SF Pro Text',
                ),
              ),
            ),
          ),
          const SizedBox(width: 52),
        ],
      ),
    );
  }
}

class _TrafficLight extends StatefulWidget {
  final Color color;
  final VoidCallback? onTap;

  const _TrafficLight({required this.color, this.onTap});

  @override
  State<_TrafficLight> createState() => _TrafficLightState();
}

class _TrafficLightState extends State<_TrafficLight> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
            boxShadow: _isHovered && widget.onTap != null
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.6),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Transform.scale(
            scale: _isHovered && widget.onTap != null ? 1.15 : 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
