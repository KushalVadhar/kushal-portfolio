import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class SpotlightSearch extends StatefulWidget {
  final VoidCallback onClose;
  final Function(String) onAppSelected;

  const SpotlightSearch({
    super.key,
    required this.onClose,
    required this.onAppSelected,
  });

  @override
  State<SpotlightSearch> createState() => _SpotlightSearchState();
}

class _SpotlightSearchState extends State<SpotlightSearch> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // Search data
  final List<SpotlightItem> _allItems = [
    SpotlightItem(
      title: 'About Me',
      subtitle: 'Learn more about my background',
      icon: Icons.person_outline,
      action: 'About',
    ),
    SpotlightItem(
      title: 'Projects',
      subtitle: 'View my featured work',
      icon: Icons.folder_open,
      action: 'Projects',
    ),
    SpotlightItem(
      title: 'Skills',
      subtitle: 'Technical expertise & tools',
      icon: Icons.code,
      action: 'Skills',
    ),
    SpotlightItem(
      title: 'Contact',
      subtitle: 'Get in touch',
      icon: Icons.mail_outline,
      action: 'Contact',
    ),
    SpotlightItem(
      title: 'Terminal',
      subtitle: 'Open terminal',
      icon: Icons.terminal,
      action: 'Terminal',
    ),
    SpotlightItem(
      title: 'Resume',
      subtitle: 'Download my resume',
      icon: Icons.description_outlined,
      action: 'Resume',
    ),
  ];

  List<SpotlightItem> _filteredItems = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_allItems);
    // Request focus after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = List.from(_allItems);
      } else {
        _filteredItems = _allItems.where((item) {
          return item.title.toLowerCase().contains(query.toLowerCase()) ||
              item.subtitle.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
      _selectedIndex = 0;
    });
  }

  void _handleSelection() {
    if (_filteredItems.isNotEmpty) {
      widget.onAppSelected(_filteredItems[_selectedIndex].action);
      widget.onClose();
    }
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        setState(() {
          _selectedIndex = (_selectedIndex + 1) % _filteredItems.length;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        setState(() {
          _selectedIndex = (_selectedIndex - 1 + _filteredItems.length) %
              _filteredItems.length;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.enter) {
        _handleSelection();
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        widget.onClose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode:
          FocusNode(), // Dummy node for capturing keys if text field doesn't
      onKey: _handleKeyEvent,
      child: Stack(
        children: [
          // Backdrop to close on click outside
          Positioned.fill(
            child: GestureDetector(
              onTap: widget.onClose,
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
          ),

          // Spotlight Window
          Center(
            child: Container(
              width: 600,
              constraints: const BoxConstraints(maxHeight: 400),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E).withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.search,
                            color: Colors.white54, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Spotlight Search',
                              hintStyle: TextStyle(
                                color: Colors.white24,
                                fontSize: 22,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: _handleSearch,
                            onSubmitted: (_) => _handleSelection(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider
                  if (_filteredItems.isNotEmpty)
                    Divider(height: 1, color: Colors.white.withOpacity(0.1)),

                  // Results List
                  if (_filteredItems.isNotEmpty)
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          final isSelected = index == _selectedIndex;

                          return MouseRegion(
                            onEnter: (_) =>
                                setState(() => _selectedIndex = index),
                            child: GestureDetector(
                              onTap: _handleSelection,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF0061F2).withOpacity(
                                          0.8) // MacBook selection blue
                                      : Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      item.icon,
                                      size: 20,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.white70,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            item.subtitle,
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : Colors.white38,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isSelected)
                                      const Icon(
                                        Icons.keyboard_return,
                                        size: 16,
                                        color: Colors.white54,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  // Empty State
                  if (_filteredItems.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No results found',
                        style: TextStyle(color: Colors.white38),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpotlightItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String action;

  SpotlightItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.action,
  });
}
