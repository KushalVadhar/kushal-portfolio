import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/desktop.dart';
import 'providers/window_state.dart';
import 'providers/theme_state.dart';
import 'widgets/common/multilingual_loader.dart';

void main() {
  runApp(const MacOsPortfolioApp());
}

class MacOsPortfolioApp extends StatefulWidget {
  const MacOsPortfolioApp({super.key});

  @override
  State<MacOsPortfolioApp> createState() => _MacOsPortfolioAppState();
}

class _MacOsPortfolioAppState extends State<MacOsPortfolioApp> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WindowState()),
        ChangeNotifierProvider(create: (_) => ThemeState()),
      ],
      child: MaterialApp(
        title: 'Kushal Vadhar Portfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'San Francisco',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.transparent,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            },
          ),
        ),
        home: Stack(
          children: [
            const Desktop(),
            if (_isLoading)
              MultilingualLoader(
                onLoadingComplete: () {
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
