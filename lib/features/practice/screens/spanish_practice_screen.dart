import 'package:flutter/material.dart';
import 'package:korean_spanish_app/features/practice/widgets/option_practice_screen.dart';

class SpanishPracticeScreen extends StatelessWidget {
  const SpanishPracticeScreen({super.key});

  /* final List<String> wordsEs = const [
    'Amor',
    'Amigo',
    'Escuela',
    'Comida',
    'Felicidad',
    'Libro',
    'Gato',
  ];*/

  @override
  Widget build(BuildContext context) {
    /*  final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('🇪🇸 Español')),
      floatingActionButton: _buildBackButton(context, isDark),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: wordsEs.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: isDark ? Colors.orange.shade700 : Colors.orange.shade100,
            child: ListTile(
              title: Center(
                child: Text(
                  wordsEs[index],
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );*/

    return const OptionPracticeScreen(hideKorean: true);
  }
}

/*
Widget _buildBackButton(BuildContext context, bool isDark) {
  return FloatingActionButton(
    onPressed: () => Navigator.pop(context),
    backgroundColor: isDark ? Colors.purpleAccent : Colors.deepPurple,
    child: TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 1.2),
      duration: const Duration(milliseconds: 700),
      curve: Curves.elasticOut,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: const Icon(Icons.arrow_back, size: 28),
    ),
  );
}
*/