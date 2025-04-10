import 'package:flutter/material.dart';
import 'package:korean_spanish_app/common/widgets/loader.dart';
import 'package:korean_spanish_app/providers/word_provider.dart';
import 'package:provider/provider.dart';

class WordListScreen extends StatefulWidget {
  const WordListScreen({super.key});

  @override
  State<WordListScreen> createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  final List<Map<String, String>> wordPairs = const [
    {'ko': '사랑', 'es': 'Amor'},
    {'ko': '친구', 'es': 'Amigo'},
    {'ko': '학교', 'es': 'Escuela'},
    {'ko': '음식', 'es': 'Comida'},
    {'ko': '행복', 'es': 'Felicidad'},
    {'ko': '책', 'es': 'Libro'},
    {'ko': '고양이', 'es': 'Gato'},
    {'ko': '강아지', 'es': 'Perro'},
    {'ko': '물', 'es': 'Agua'},
    {'ko': '불', 'es': 'Fuego'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward(); // inicia la animación al entrar a la pantalla

    Future.microtask(
        () => Provider.of<WordProvider>(context, listen: false).loadWords());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildListItem(String korean, String spanish, bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: isDark
            ? const LinearGradient(
                colors: [Color(0xFF3A0CA3), Color(0xFF4361EE)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : const LinearGradient(
                colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.purple.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.language, color: Colors.white, size: 30),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                korean,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                spanish,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final words = Provider.of<WordProvider>(context).words;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Palabras'),
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      body: words.isEmpty
          ? const Loader()
          : ListView.builder(
              // itemCount: wordPairs.length,
              // itemBuilder: (context, index) {
              //   final pair = wordPairs[index];
              //   return buildListItem(pair['ko']!, pair['es']!, isDark);
              // },
              itemCount: words.length,
              itemBuilder: (context, index) {
                final pair = words[index];
                return buildListItem(pair.korean, pair.spanish, isDark);
              },
            ),
      floatingActionButton: ScaleTransition(
        scale: _scaleAnimation,
        child: FloatingActionButton.extended(
          onPressed: () => Navigator.pop(context),
          backgroundColor: isDark
              ? Colors.purpleAccent
              :
              //Colors.deepPurple,
              Colors.white,
          icon: const Icon(Icons.arrow_back),
          label: const Text('Volver'),
        ),
      ),
    );
  }
}
