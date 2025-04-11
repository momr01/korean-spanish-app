import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:korean_spanish_app/common/layouts/main_screen.dart';
import 'package:korean_spanish_app/common/widgets/loader.dart';
import 'package:korean_spanish_app/common/widgets/main_title.dart';
import 'package:korean_spanish_app/features/games/screens/game_home_screen.dart';
import 'package:korean_spanish_app/features/home/widgets/word_card.dart';
import 'package:korean_spanish_app/features/practice/screens/practice_options_screen.dart';
import 'package:korean_spanish_app/features/practice/screens/practice_screen.dart';
import 'package:korean_spanish_app/features/statistics/screens/statistics_screen.dart';
import 'package:korean_spanish_app/features/words/screens/add_word_screen.dart';
import 'package:korean_spanish_app/features/words/screens/words_list_screen.dart';
import 'package:korean_spanish_app/features/words/services/words_services.dart';
import 'package:korean_spanish_app/models/word/word.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  //final ValueNotifier<ThemeMode> themeNotifier;
  const HomeScreen({
    super.key,
    //required this.themeNotifier
  });

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final List<Map<String, String>> wordPairs = const [
    {'ko': '사랑', 'es': 'Amor'},
    {'ko': '친구', 'es': 'Amigo'},
    {'ko': '학교', 'es': 'Escuela'},
    {'ko': '음식', 'es': 'Comida'},
    {'ko': '행복', 'es': 'Felicidad'},
    {'ko': '책', 'es': 'Libro'},
    {'ko': '고양이', 'es': 'Gato'},
  ];

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
          // showAll: false,
          // hideSpanish: true,
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

  Route createPracticeRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const PracticeOptionsScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack, // efecto de rebote sutil
        );
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0), // empieza desde la derecha
          end: Offset.zero,
        ).animate(curvedAnimation);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  // void toggleTheme() {
  //   if (_themeNotifier.value == ThemeMode.light) {
  //     _themeNotifier.value = ThemeMode.dark;
  //   } else {
  //     _themeNotifier.value = ThemeMode.light;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier = Provider.of<ValueNotifier<ThemeMode>>(context);

    void toggleTheme() {
      if (themeNotifier.value == ThemeMode.light) {
        themeNotifier.value = ThemeMode.dark;
      } else {
        themeNotifier.value = ThemeMode.light;
      }
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        /*drawer: const Drawer(
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
            ],
          ),
        ),
      ),*/
        /*
       * 
       * 
       * 
       * 
       * 
      
      drawer: Drawer(
  child: SafeArea(
    child: Column(
      children: [
        const DrawerHeader(
          child: Text('🌐 Menú', style: TextStyle(fontSize: 24)),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Inicio'),
          onTap: () {
            Navigator.pop(context); // Cierra el drawer
            // Ya estás en inicio
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Modo práctica'),
          onTap: () {
            Navigator.pop(context); // Cierra el drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PracticeOptionsPage()),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Configuración'),
          onTap: () {
            Navigator.pop(context);
            // Aquí podrías redirigir a una futura pantalla de settings
          },
        ),
      ],
    ),
  ),
),

      
      */
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                /*const DrawerHeader(
          child: Text('🌐 Menú'),
        ),*/
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: Theme.of(context).brightness == Brightness.dark
                          ? [Colors.deepPurple[800]!, Colors.deepPurpleAccent]
                          : [Colors.deepPurple, Colors.deepPurpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.zero,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.menu_book_rounded,
                          size: 40, color: Colors.white),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '🌐 Menú principal',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tu viaje al coreano comienza aquí',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Inicio'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.view_list),
                  title: const Text('Lista de palabras'),
                  onTap: () {
                    Navigator.pop(context); // Cierra el drawer
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const WordListScreen(),
                        transitionsBuilder: (_, animation, __, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          return SlideTransition(
                              position: animation.drive(tween), child: child);
                        },
                      ),
                    );
                  },
                ),
                /*  ListTile(
  leading: const Icon(Icons.book),
  title: const Text('Modo práctica'),
  onTap: () {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PracticeOptionsPage()),
    );
  },
),*/
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('Modo práctica'),
                  onTap: () {
                    Navigator.pop(context); // Cierra el drawer
                    Navigator.of(context).push(createPracticeRoute());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bar_chart_rounded),
                  title: const Text('Estadísticas'),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (_, __, ___) => const StatisticsScreen(),
                        transitionsBuilder: (_, animation, __, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                                parent: animation, curve: Curves.easeInOut)),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.sports_esports),
                  title: const Text('Modo juego'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (_, __, ___) => const GameHomeScreen(),
                        transitionsBuilder: (_, animation, __, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                                parent: animation, curve: Curves.easeInOut)),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Configuración'),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                      'Aprende Coreano 🇰🇷',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.deepPurple,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isDark
                            ? Icons.wb_sunny_rounded
                            : Icons.nightlight_round,
                        color: isDark ? Colors.yellow[300] : Colors.indigo[700],
                      ),
                      onPressed: toggleTheme,
                    ),
                  ],
                ),
              ),

              // Sección de cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '✨ Palabras del día',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
              /*  SizedBox(
              height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: wordPairs.length,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  final pair = wordPairs[index];
                  return buildCard(pair['ko']!, pair['es']!, isDark);
                },
              ),
            ),*/

              const Spacer(),

              /*Center(
              child: Image.network(
                'https://cdn.pixabay.com/photo/2020/04/17/03/59/korean-5052740_1280.png',
                height: 120,
                fit: BoxFit.contain,
                color: isDark ? Colors.white70 : null,
              ),
            ),*/
              const SizedBox(height: 24),

              /*  FloatingActionButton(
              
              
  onPressed: () {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(parent: animation, curve: Curves.elasticOut);
          return ScaleTransition(
            scale: curved,
            child: child,
          );
        },
        pageBuilder: (_, __, ___) => const AddWordPage(),
      ),
    );
  },
  backgroundColor: Colors.deepPurpleAccent,
              
  elevation: 6,
  child: const Icon(Icons.add, size: 28, color: Colors.white),
),*/
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final curved = CurvedAnimation(
                        parent: animation, curve: Curves.elasticOut);
                    return ScaleTransition(
                      scale: curved,
                      child: child,
                    );
                  },
                  pageBuilder: (_, __, ___) => const AddWordScreen(),
                ),
              );
            },
            backgroundColor: Colors.deepPurpleAccent,
            elevation: 6,
            child: const Icon(Icons.add, size: 28, color: Colors.white),
          ),
        ));
  }

/*
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MainScreen(
        mainTitle: "Todas las palabras",
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
  }*/
}
