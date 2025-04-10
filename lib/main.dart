import 'package:flutter/material.dart';
import 'package:korean_spanish_app/constants/navigator_keys.dart';
import 'package:korean_spanish_app/features/home/screens/home_screen.dart';
import 'package:korean_spanish_app/providers/word_provider.dart';
import 'package:korean_spanish_app/router.dart';
import 'package:provider/provider.dart';

final ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier(ThemeMode.system);

//void main() => runApp(const HangulWordsApp());
// void main() {
//   runApp(
//     ChangeNotifierProvider<ValueNotifier<ThemeMode>>.value(
//       value: _themeNotifier,
//       child: const HangulWordsApp(),
//     ),
//   );
// }
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ValueNotifier<ThemeMode>>.value(
          value: _themeNotifier,
        ),
        ChangeNotifierProvider<WordProvider>(
          create: (_) => WordProvider(),
        ),
      ],
      child: const HangulWordsApp(),
    ),
  );
}

class HangulWordsApp extends StatelessWidget {
  const HangulWordsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeNotifier,
      builder: (_, currentTheme, __) {
        return MaterialApp(
          title: 'Aprende Coreano',
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigatorKeys.navKey,
          themeMode: currentTheme,
          theme: ThemeData(
            brightness: Brightness.light,
            fontFamily: 'Segoe UI',
            scaffoldBackgroundColor: const Color(0xFFF3F1F9),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'Segoe UI',
            scaffoldBackgroundColor: const Color(0xFF1A1A2E),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.purpleAccent,
              brightness: Brightness.dark,
            ),
          ),
          onGenerateRoute: (settings) => generateRoute(settings),
          home: const HomeScreen(),
        );
      },
    );
  }
}
