import 'package:flutter/material.dart';
import 'package:korean_spanish_app/common/layouts/main_screen.dart';
import 'package:korean_spanish_app/common/widgets/loader.dart';
import 'package:korean_spanish_app/features/home/widgets/word_card.dart';
import 'package:korean_spanish_app/features/words/services/words_services.dart';
import 'package:korean_spanish_app/models/word/word.dart';

class SpanishHiddenScreen extends StatefulWidget {
  static const String routeName = '/practice-spanish-hidden';
  const SpanishHiddenScreen({super.key});

  @override
  State<SpanishHiddenScreen> createState() => _SpanishHiddenScreenState();
}

class _SpanishHiddenScreenState extends State<SpanishHiddenScreen> {
  List<Word>? words;
  List<Word> _foundWords = [];

  final WordsServices _wordsServices = WordsServices();

  @override
  void initState() {
    super.initState();
    fetchWords();
  }

  fetchWords() async {
    words = await _wordsServices.fetchWords();

    setState(() {
      _foundWords = words!;
      _foundWords.shuffle();
      // _foundPayments.sort((a, b) {
      // Extraer año y mes de cada período
      // final yearA = int.parse(a.period.split('-')[1]);
      // final monthA = int.parse(a.period.split('-')[0]);
      // final yearB = int.parse(b.period.split('-')[1]);
      // final monthB = int.parse(b.period.split('-')[0]);

      // // Ordenar primero por año y luego por mes
      // if (yearA == yearB) {
      //   return monthA.compareTo(monthB);
      // }
      // return yearA.compareTo(yearB);

      //  });
      //_isLoading = false;
    });
  }

  Widget buildCard(String korean, String spanish, bool isDark) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        // width: 160,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isDark
              ? const LinearGradient(
                  colors: [Color(0xFF4E148C), Color(0xFF2D0A5F)],
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
              color: isDark ? Colors.black45 : Colors.purple.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(2, 4),
            )
          ],
        ),
        child:
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         const Spacer(),
            //         Text(
            //           korean,
            //           style: const TextStyle(
            //             fontSize: 40,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white,
            //           ),
            //         ),
            //         const SizedBox(height: 10),
            //         Text(
            //           spanish,
            //           style: TextStyle(
            //             fontSize: 30,
            //             color: Colors.white.withOpacity(0.9),
            //           ),
            //         ),
            //         const Spacer(),
            //         Icon(
            //           Icons.visibility_off,
            //           size: 30,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            WordCard(
          korean: korean,
          spanish: spanish,
          showAll: false,
          hideSpanish: true,
        ));
  }

  // void toggleTheme() {
  //   if (widget.themeNotifier.value == ThemeMode.light) {
  //     widget.themeNotifier.value = ThemeMode.dark;
  //   } else {
  //     widget.themeNotifier.value = ThemeMode.light;
  //   }
  // }

  // void fromHomeToPractice(context) {
  //   Navigator.pushNamed(context, PracticeScreen.routeName);
  // }

  // void navigateToStartPractice() {
  //   fromHomeToPractice(context);
  // }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MainScreen(
        mainTitle: "Coreano - Español oculto",
        child: _foundWords.isNotEmpty
            ? SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // itemCount: wordPairs.length,
                  itemCount: _foundWords.length,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, index) {
                    // final pair = wordPairs[index];
                    // return buildCard(pair['ko']!, pair['es']!, isDark);
                    return buildCard(_foundWords[index].korean,
                        _foundWords[index].spanish, isDark);
                  },
                ),
              )
            : const Center(child: Loader()));

    /* return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                child: Text('🌐 Menú'),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Inicio'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configuración'),
              ),
              GestureDetector(
                onTap: navigateToStartPractice,
                child: ListTile(
                  leading: Icon(Icons.list_alt_sharp),
                  title: Text('Practicar'),
                ),
              ),
            ],
          ),
        ),
      ),
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

            // Sección de cards
            // Padding(
            //   //padding: const EdgeInsets.symmetric(horizontal: 16),
            //   padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
            //   child: Text(
            //     '✨ Todas las palabras',
            //     style: TextStyle(
            //       fontSize: 30,
            //       fontWeight: FontWeight.w600,
            //       color: isDark ? Colors.white : Colors.black87,
            //     ),
            //   ),
            // ),
            MainTitle(isDark: isDark, text: "Todas las palabras"),
            const SizedBox(height: 30),
            _foundWords.isNotEmpty
                ? SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // itemCount: wordPairs.length,
                      itemCount: _foundWords.length,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemBuilder: (context, index) {
                        // final pair = wordPairs[index];
                        // return buildCard(pair['ko']!, pair['es']!, isDark);
                        return buildCard(_foundWords[index].korean,
                            _foundWords[index].spanish, isDark);
                      },
                    ),
                  )
                : const Center(child: Loader()),

            const Spacer(),

            /* Center(
              child: Image.network(
                'https://cdn.pixabay.com/photo/2020/04/17/03/59/korean-5052740_1280.png',
                height: 120,
                fit: BoxFit.contain,
                color: isDark ? Colors.white70 : null,
              ),
            ),*/
            const SizedBox(height: 24),
          ],
        ),
      ),
    );*/
  }
}
