import 'package:flutter/material.dart';
import 'package:korean_spanish_app/features/practice/screens/korean_practice_screen.dart';
import 'package:korean_spanish_app/features/practice/screens/spanish_practice_screen.dart';
import 'package:korean_spanish_app/providers/word_provider.dart';
import 'package:provider/provider.dart';

class PracticeOptionsScreen extends StatefulWidget {
  const PracticeOptionsScreen({super.key});

  @override
  State<PracticeOptionsScreen> createState() => _PracticeOptionsScreenState();
}

class _PracticeOptionsScreenState extends State<PracticeOptionsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<WordProvider>(context, listen: false).loadWords());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final words = Provider.of<WordProvider>(context).words;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo práctica'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          children: [
            const Text(
              '¿Qué querés practicar hoy?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _buildOptionCard(
              context: context,
              label: '🈶 Solo Coreano',
              color1: Colors.purple,
              color2: Colors.deepPurple,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => KoreanPracticeScreen(),
                    transitionsBuilder: (_, anim, __, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: anim,
                          curve: Curves.easeOutBack,
                        )),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            _buildOptionCard(
              context: context,
              label: '🇪🇸 Solo Español',
              color1: Colors.orangeAccent,
              color2: Colors.deepOrange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const SpanishPracticeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required String label,
    required Color color1,
    required Color color2,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 140,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: color1.withOpacity(0.5),
              blurRadius: 12,
              offset: const Offset(4, 6),
            )
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
