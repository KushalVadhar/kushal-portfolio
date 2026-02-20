import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MultilingualLoader extends StatefulWidget {
  final VoidCallback onLoadingComplete;

  const MultilingualLoader({super.key, required this.onLoadingComplete});

  @override
  State<MultilingualLoader> createState() => _MultilingualLoaderState();
}

class _MultilingualLoaderState extends State<MultilingualLoader> {
  final List<String> _greetings = [
    'Hello',
    'Hola',
    'नमस्ते',
    'Bonjour',
    'Ciao',
  ];

  int _currentIndex = 0;
  bool _isExiting = false;

  @override
  void initState() {
    super.initState();
    _startAnimationCycle();
  }

  void _startAnimationCycle() async {
    // Ultra-rapid greeting cycle
    for (int i = 1; i < _greetings.length; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
      if (mounted) {
        setState(() {
          _currentIndex = i;
        });
      }
    }

    // Final greeting stays briefly
    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      setState(() {
        _isExiting = true;
      });
    }

    // Wait for the exit animation to complete before removing from Stack
    await Future.delayed(const Duration(milliseconds: 300));
    widget.onLoadingComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isExiting ? 0.0 : 1.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Minimalist dot indicator
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(_greetings.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == _currentIndex
                            ? Colors.blueAccent
                            : Colors.white10,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),

                // Greeting Text
                Animate(
                  key: ValueKey(_currentIndex),
                  effects: [
                    FadeEffect(duration: 400.ms, curve: Curves.easeOut),
                    SlideEffect(
                        begin: const Offset(0, 0.2),
                        end: Offset.zero,
                        duration: 400.ms,
                        curve: Curves.easeOutBack),
                  ],
                  child: Text(
                    _greetings[_currentIndex],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.0,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Subtitle
                Text(
                  'KUSHAL VADHAR PORTFOLIO',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.2),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4.0,
                  ),
                ).animate().fadeIn(delay: 500.ms, duration: 800.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
