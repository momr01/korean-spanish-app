import 'package:flutter/material.dart';
import 'package:korean_spanish_app/common/widgets/loader.dart';
import 'package:korean_spanish_app/providers/word_provider.dart';
import 'package:provider/provider.dart';
import 'package:characters/characters.dart';

String normalize(String text) {
  final withDiacritics = 'áàäâãéèëêíìïîóòöôõúùüûñÁÀÄÂÃÉÈËÊÍÌÏÎÓÒÖÔÕÚÙÜÛÑ';
  final withoutDiacritics = 'aaaaaeeeeiiiiooooouuuunAAAAAEEEEIIIIOOOOOUUUUN';

  for (int i = 0; i < withDiacritics.length; i++) {
    text = text.replaceAll(withDiacritics[i], withoutDiacritics[i]);
  }

  return text.toLowerCase();
}

class WordListScreen extends StatefulWidget {
  const WordListScreen({super.key});

  @override
  State<WordListScreen> createState() => _WordListScreenState();
}

/*
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
*/
class _WordListScreenState extends State<WordListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

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
    _controller.forward();

    Future.microtask(
      () => Provider.of<WordProvider>(context, listen: false).loadWords(),
    );

    _searchController.addListener(() {
      setState(() {
        _searchTerm = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }
/*
  TextSpan highlightText(String text, String query) {
    if (query.isEmpty) {
      return TextSpan(
        text: text,
        style: const TextStyle(fontSize: 22, color: Colors.white),
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        spans.add(TextSpan(
          text: text.substring(start),
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ));
        break;
      }

      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ));
      }

      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
        ),
      ));

      start = index + query.length;
    }

    return TextSpan(children: spans);
  }*/

  TextSpan highlightText(String originalText, String query) {
    if (query.isEmpty) {
      return TextSpan(
        text: originalText,
        style: const TextStyle(fontSize: 22, color: Colors.white),
      );
    }

    final normalizedText = normalize(originalText);
    final normalizedQuery = normalize(query);

    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final index = normalizedText.indexOf(normalizedQuery, start);
      if (index == -1) {
        spans.add(TextSpan(
          text: originalText.substring(start),
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ));
        break;
      }

      if (index > start) {
        spans.add(TextSpan(
          text: originalText.substring(start, index),
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ));
      }

      spans.add(TextSpan(
        text: originalText.substring(index, index + query.length),
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
        ),
      ));

      start = index + query.length;
    }

    return TextSpan(children: spans);
  }

  Widget buildListItem(
      String korean, String spanish, bool isDark, String query, int index) {
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
          //   const Icon(Icons.language, color: Colors.white, size: 30),
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isDark
                  ? const LinearGradient(
                      colors: [Color(0xFF7209B7), Color(0xFF4361EE)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : const LinearGradient(
                      colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              boxShadow: [
                BoxShadow(
                  color:
                      isDark ? Colors.black26 : Colors.purple.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: highlightText(korean, query),
              ),
              RichText(
                text: highlightText(spanish, query),
              ),
            ],
          ),
        ],
      ),
    );
  }

/*
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
              // Text(
              //   korean,
              //   style: const TextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.w600,
              //     color: Colors.white,
              //   ),
              // ),
              // Text(
              //   spanish,
              //   style: TextStyle(
              //     fontSize: 16,
              //     color: Colors.white.withOpacity(0.9),
              //   ),
              // ),
              Text.rich(
                highlightText(korean, _searchTerm),
              ),
              Text.rich(
                highlightText(spanish, _searchTerm),
              ),
            ],
          ),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final words = Provider.of<WordProvider>(context).words;

    // final filteredWords = words.where((pair) {
    //   return pair.spanish.toLowerCase().contains(_searchTerm);
    // }).toList();
    final filteredWords = words.where((pair) {
      final spanish = pair.spanish.toLowerCase();
      final korean = pair.korean.toLowerCase();
      return spanish.contains(_searchTerm) || korean.contains(_searchTerm);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Palabras'),
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      body: words.isEmpty
          ? const Loader()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar en español o coreano...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: isDark ? Colors.grey[900] : Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                /*Expanded(
                  child: ListView.builder(
                    itemCount: filteredWords.length,
                    itemBuilder: (context, index) {
                      final pair = filteredWords[index];
                      return buildListItem(pair.korean, pair.spanish, isDark);
                    },
                  ),
                ),*/
                /* Expanded(
                  child: ListView.builder(
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      final pair = words[index];

                      final koNorm = normalize(pair.korean);
                      final esNorm = normalize(pair.spanish);
                      final queryNorm = normalize(_searchTerm);

                      if (_searchTerm.isNotEmpty &&
                          !koNorm.contains(queryNorm) &&
                          !esNorm.contains(queryNorm)) {
                        return const SizedBox.shrink(); // oculta si no coincide
                      }

                      return buildListItem(
                        pair.korean,
                        pair.spanish,
                        isDark,
                        _searchTerm,
                      );
                    },
                  ),
                ),*/
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final filteredWords = words.where((pair) {
                        final koNorm = normalize(pair.korean);
                        final esNorm = normalize(pair.spanish);
                        final queryNorm = normalize(_searchTerm);

                        return _searchTerm.isEmpty ||
                            koNorm.contains(queryNorm) ||
                            esNorm.contains(queryNorm);
                      }).toList();

                      /*   if (filteredWords.isEmpty) {
                        return Center(
                          child: Text(
                            'No se encontraron resultados',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        );
                      }*/
                      if (filteredWords.isEmpty) {
                        return FadeTransition(
                          opacity: _controller,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off_rounded,
                                  size: 64,
                                  color:
                                      isDark ? Colors.white24 : Colors.black26),
                              const SizedBox(height: 12),
                              Text(
                                'No se encontraron resultados',
                                style: TextStyle(
                                  color:
                                      isDark ? Colors.white70 : Colors.black54,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: filteredWords.length,
                        itemBuilder: (context, index) {
                          final pair = filteredWords[index];
                          return buildListItem(pair.korean, pair.spanish,
                              isDark, _searchTerm, index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: ScaleTransition(
        scale: _scaleAnimation,
        child: FloatingActionButton.extended(
          onPressed: () => Navigator.pop(context),
          backgroundColor: isDark ? Colors.purpleAccent : Colors.white,
          icon: const Icon(Icons.arrow_back),
          label: const Text('Volver'),
        ),
      ),
    );
  }
}
