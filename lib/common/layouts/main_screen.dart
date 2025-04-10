import 'package:flutter/material.dart';
import 'package:korean_spanish_app/common/widgets/leftMenuBar.dart';
import 'package:korean_spanish_app/common/widgets/main_title.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  final String mainTitle;
  const MainScreen({super.key, required this.child, required this.mainTitle});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier = Provider.of<ValueNotifier<ThemeMode>>(context);

    void toggleTheme() {
      if (themeNotifier.value == ThemeMode.light) {
        themeNotifier.value = ThemeMode.dark;
      } else {
        themeNotifier.value = ThemeMode.light;
      }
    }

    return Scaffold(
      drawer: const LeftMenuBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar personalizado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu_rounded,
                          size: 30,
                          color: isDark ? Colors.white : Colors.deepPurple),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  Text(
                    'Aprendé Coreano 🇰🇷',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.deepPurple,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                      color: isDark ? Colors.yellow[300] : Colors.indigo[700],
                    ),
                    onPressed: toggleTheme,
                  ),
                ],
              ),
            ),
            MainTitle(isDark: isDark, text: widget.mainTitle),
            const SizedBox(height: 30),
            widget.child,
            const Spacer(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
