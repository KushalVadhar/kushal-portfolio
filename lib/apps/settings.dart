import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_state.dart';

class SettingsApp extends StatefulWidget {
  const SettingsApp({super.key});

  @override
  State<SettingsApp> createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  String _activeSection = 'Wallpaper';
  bool _isScanning = false;

  void _scanWifi() async {
    setState(() => _isScanning = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isScanning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      color: const Color(0xFFF5F5F7),
      child: Row(
        children: [
          // Sidebar - Hidden on mobile
          if (!isMobile)
            Container(
              width: 200,
              color: const Color(0xFFE5E5E5).withOpacity(0.5),
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  _SidebarItem(
                    icon: Icons.wallpaper,
                    label: 'Wallpaper',
                    isSelected: _activeSection == 'Wallpaper',
                    onTap: () => setState(() => _activeSection = 'Wallpaper'),
                  ),
                  _SidebarItem(
                    icon: Icons.wifi,
                    label: 'Network',
                    isSelected: _activeSection == 'Network',
                    onTap: () {
                      setState(() => _activeSection = 'Network');
                      _scanWifi();
                    },
                  ),
                ],
              ),
            ),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(isMobile ? 16 : 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black12)),
                  ),
                  width: double.infinity,
                  child: Text(
                    _activeSection,
                    style: TextStyle(
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: _activeSection == 'Wallpaper'
                      ? _buildWallpaperGrid(isMobile)
                      : _buildNetworkView(isMobile),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWallpaperGrid(bool isMobile) {
    return Consumer<ThemeState>(
      builder: (context, themeState, _) {
        return GridView.builder(
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 2 : 3,
            crossAxisSpacing: isMobile ? 12 : 16,
            mainAxisSpacing: isMobile ? 12 : 16,
            childAspectRatio: 1.6,
          ),
          itemCount: ThemeState.wallpapers.length,
          itemBuilder: (context, index) {
            final isSelected = themeState.currentWallpaperIndex == index;
            return GestureDetector(
              onTap: () => themeState.setWallpaper(index),
              child: Container(
                decoration: BoxDecoration(
                  gradient: ThemeState.wallpapers[index],
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: Colors.blueAccent, width: 4)
                      : Border.all(color: Colors.black12, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: isSelected
                    ? const Center(
                        child: Icon(Icons.check_circle,
                            color: Colors.white, size: 32),
                      )
                    : null,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildNetworkView(bool isMobile) {
    return ListView(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Wi-Fi",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Switch(value: true, onChanged: (_) {}),
                ],
              ),
              const Divider(),
              if (_isScanning)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                )
              else ...[
                _WifiItem(name: "Kushal_5G", isConnected: true),
                _WifiItem(name: "Interlink_Office", isConnected: false),
                _WifiItem(name: "Starbucks_Free", isConnected: false),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _WifiItem extends StatelessWidget {
  final String name;
  final bool isConnected;

  const _WifiItem({required this.name, required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(Icons.wifi,
              color: isConnected ? Colors.blue : Colors.black54, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(name,
                style: TextStyle(
                    fontWeight:
                        isConnected ? FontWeight.bold : FontWeight.normal)),
          ),
          if (isConnected)
            const Icon(Icons.check, color: Colors.blue, size: 16),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.black.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 18, color: isSelected ? Colors.blue : Colors.black87),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.blue : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
