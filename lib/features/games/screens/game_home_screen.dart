/*


class GameHomePage extends StatefulWidget {
  const GameHomePage({super.key});

  @override
  State<GameHomePage> createState() => _GameHomePageState();
}

class _GameHomePageState extends State<GameHomePage> {
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  bool isGameStarted = false;
  String currentWord = '';
  final TextEditingController controller = TextEditingController();
  Timer? _timer;
  Duration elapsed = Duration.zero;
  final List<Map<String, String>> words = [
    {'kr': '안녕하세요', 'es': 'hola'},
    {'kr': '감사합니다', 'es': 'gracias'},
    {'kr': '사랑해요', 'es': 'te amo'},
    {'kr': '잘 지내요?', 'es': 'como estas'},
  ];
  int wordIndex = 0;

  void startGame() {
    setState(() {
      isGameStarted = true;
      correctAnswers = 0;
      incorrectAnswers = 0;
      wordIndex = 0;
      elapsed = Duration.zero;
      currentWord = words[wordIndex]['kr']!;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        elapsed += const Duration(seconds: 1);
      });
    });
  }

  void validateAnswer() {
    final answer = controller.text.trim().toLowerCase();
    final correct = words[wordIndex]['es']!.toLowerCase();

    if (answer == correct) {
      setState(() {
        correctAnswers++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ ¡Correcto!')),
      );
    } else {
      setState(() {
        incorrectAnswers++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Incorrecto. Era "$correct"')),
      );
    }

    controller.clear();

    Future.delayed(const Duration(milliseconds: 800), () {
      if (wordIndex + 1 < words.length) {
        setState(() {
          wordIndex++;
          currentWord = words[wordIndex]['kr']!;
        });
      } else {
        endGame();
      }
    });
  }

  void endGame() {
    _timer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🏁 ¡Juego terminado!'),
        content: Text(
          'Tiempo total: ${elapsed.inSeconds} segundos\n'
          '✅ Correctas: $correctAnswers\n'
          '❌ Incorrectas: $incorrectAnswers',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              startGame();
            },
            child: const Text('Nueva partida'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                isGameStarted = false;
                controller.clear();
              });
            },
            child: const Text('Volver'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎮 Modo Juego'),
        backgroundColor: isDark ? Colors.deepPurple[900] : Colors.deepPurple,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: isGameStarted
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text('✅ Correctas'),
                          Text('$correctAnswers',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            const Text('⏱ Tiempo'),
                            Text('${elapsed.inSeconds}s',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const Text('❌ Incorrectas'),
                          Text('$incorrectAnswers',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    currentWord,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Tu respuesta en español',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      filled: true,
                      fillColor:
                          isDark ? Colors.white10 : Colors.grey.shade100,
                    ),
                    style: TextStyle(fontSize: 18, color: textColor),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Validar'),
                    onPressed: validateAnswer,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text('Abandonar partida'),
                    onPressed: endGame,
                  ),
                ],
              )
            : Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Iniciar nueva partida'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: startGame,
                ),
              ),
      ),
    );
  }
}

*/

import 'dart:async';

import 'package:flutter/material.dart';

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$minutes:$seconds";
}

class GameHomeScreen extends StatelessWidget {
  const GameHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎮 Modo Juego'),
        backgroundColor: isDark ? Colors.deepPurple[900] : Colors.deepPurple,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '¡Elige un modo de juego!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GameClassicModePage()),
              ),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Modo clásico'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GameTimerModePage()),
              ),
              icon: const Icon(Icons.timer, color: Colors.white),
              label: const Text('Juego contrarreloj'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class GameClassicModePage extends StatefulWidget {
//   const GameClassicModePage({super.key});

//   @override
//   State<GameClassicModePage> createState() => _GameClassicModePageState();
// }

// class _GameClassicModePageState extends State<GameClassicModePage> {
//   final List<Map<String, String>> words = [
//     {'ko': '사랑', 'es': 'amor'},
//     {'ko': '행복', 'es': 'felicidad'},
//     {'ko': '물', 'es': 'agua'},
//   ];
//   int currentIndex = 0;
//   int correct = 0;
//   int incorrect = 0;
//   String userAnswer = '';
//   final TextEditingController _controller = TextEditingController();
//   Stopwatch stopwatch = Stopwatch();

//   @override
//   void initState() {
//     super.initState();
//     stopwatch.start();
//   }

//   void validateAnswer() {
//     final current = words[currentIndex];
//     if (userAnswer.trim().toLowerCase() == current['es']) {
//       setState(() => correct++);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('✅ ¡Correcto!')));
//     } else {
//       setState(() => incorrect++);
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('❌ Incorrecto. Era: ${current['es']}')));
//     }
//     nextWord();
//   }

//   void nextWord() {
//     _controller.clear();
//     userAnswer = '';
//     if (currentIndex < words.length - 1) {
//       setState(() => currentIndex++);
//     } else {
//       stopwatch.stop();
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: const Text('🎉 ¡Fin del juego!'),
//           content: Text(
//             '⏱️ Tiempo: ${stopwatch.elapsed.inSeconds}s\n✅ Aciertos: $correct\n❌ Errores: $incorrect',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 setState(() {
//                   currentIndex = 0;
//                   correct = 0;
//                   incorrect = 0;
//                   stopwatch.reset();
//                   stopwatch.start();
//                 });
//               },
//               child: const Text('Jugar de nuevo'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
//               child: const Text('Salir al inicio'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final word = words[currentIndex]['ko'] ?? '';
//     return Scaffold(
//       appBar: AppBar(title: const Text('Modo clásico')),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text('⏱️ ${stopwatch.elapsed.inSeconds}s',
//                 style: const TextStyle(fontSize: 20)),
//             const SizedBox(height: 16),
//             Text('✅ $correct    ❌ $incorrect',
//                 style: const TextStyle(fontSize: 20)),
//             const SizedBox(height: 32),
//             Text(word,
//                 style:
//                     const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 32),
//             TextField(
//               controller: _controller,
//               onChanged: (val) => userAnswer = val,
//               decoration:
//                   const InputDecoration(hintText: 'Traducción en español'),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: validateAnswer,
//               child: const Text('Validar'),
//             ),
//             const SizedBox(height: 20),
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('🚪 Abandonar partida'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class GameClassicModePage extends StatefulWidget {
  const GameClassicModePage({super.key});

  @override
  State<GameClassicModePage> createState() => _GameClassicModePageState();
}

class _GameClassicModePageState extends State<GameClassicModePage> {
  final List<Map<String, String>> words = [
    {'ko': '사랑', 'es': 'amor'},
    {'ko': '행복', 'es': 'felicidad'},
    {'ko': '물', 'es': 'agua'},
  ];

  int currentIndex = 0;
  int correct = 0;
  int incorrect = 0;
  String userAnswer = '';
  final TextEditingController _controller = TextEditingController();
  final Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    stopwatch.start();

    // Actualiza la UI cada segundo para mostrar el tiempo
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    stopwatch.stop();
    super.dispose();
  }

  void validateAnswer() {
    final current = words[currentIndex];
    if (userAnswer.trim().toLowerCase() == current['es']) {
      setState(() => correct++);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('✅ ¡Correcto!')));
    } else {
      setState(() => incorrect++);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Incorrecto. Era: ${current['es']}')));
    }
    nextWord();
  }

  void nextWord() {
    _controller.clear();
    userAnswer = '';
    if (currentIndex < words.length - 1) {
      setState(() => currentIndex++);
    } else {
      stopwatch.stop();
      timer?.cancel();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('🎉 ¡Fin del juego!'),
          content: Text(
            '⏱️ Tiempo: ${stopwatch.elapsed.inSeconds}s\n✅ Aciertos: $correct\n❌ Errores: $incorrect',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentIndex = 0;
                  correct = 0;
                  incorrect = 0;
                  stopwatch.reset();
                  stopwatch.start();
                  timer = Timer.periodic(
                      const Duration(seconds: 1), (_) => setState(() {}));
                });
              },
              child: const Text('Jugar de nuevo'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Vuelve a GameHomePage
                //Navigator.pushReplacementNamed(context, '/gameHome')
              },
              child: const Text('Salir al inicio'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final word = words[currentIndex]['ko'] ?? '';
    return Scaffold(
      appBar: AppBar(title: const Text('Modo clásico')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text('⏱️ ${stopwatch.elapsed.inSeconds}s',
            Text('⏱️ ${formatTime(stopwatch.elapsed)}',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Text('✅ $correct    ❌ $incorrect',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 32),
            Text(word,
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            TextField(
              controller: _controller,
              onChanged: (val) => userAnswer = val,
              decoration:
                  const InputDecoration(hintText: 'Traducción en español'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: validateAnswer,
              child: const Text('Validar'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('🚪 Abandonar partida'),
            )
          ],
        ),
      ),
    );
  }
}

class GameTimerModePage extends StatefulWidget {
  const GameTimerModePage({super.key});

  @override
  State<GameTimerModePage> createState() => _GameTimerModePageState();
}

class _GameTimerModePageState extends State<GameTimerModePage> {
  final List<Map<String, String>> words = [
    {'ko': '하늘', 'es': 'cielo'},
    {'ko': '고양이', 'es': 'gato'},
    {'ko': '친구', 'es': 'amigo'},
  ];
  int currentIndex = 0;
  int correct = 0;
  int incorrect = 0;
  String userAnswer = '';
  final TextEditingController _controller = TextEditingController();
  Timer? countdownTimer;
  int secondsLeft = 10;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    secondsLeft = 10;
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => secondsLeft--);
      if (secondsLeft <= 0) {
        timer.cancel();
        validateAnswer(autoFail: true);
      }
    });
  }

  void validateAnswer({bool autoFail = false}) {
    final current = words[currentIndex];
    countdownTimer?.cancel();
    if (!autoFail && userAnswer.trim().toLowerCase() == current['es']) {
      setState(() => correct++);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('✅ ¡Correcto!')));
    } else {
      setState(() => incorrect++);
      if (!autoFail) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('❌ Incorrecto. Era: ${current['es']}')));
      }
    }
    nextWord();
  }

  void nextWord() {
    _controller.clear();
    userAnswer = '';
    if (currentIndex < words.length - 1) {
      setState(() => currentIndex++);
      startCountdown();
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('🕒 Juego terminado'),
          content: Text('✅ Aciertos: $correct\n❌ Errores: $incorrect'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentIndex = 0;
                  correct = 0;
                  incorrect = 0;
                  startCountdown();
                });
              },
              child: const Text('Jugar de nuevo'),
            ),
            TextButton(
              onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
              //  onPressed: () => Navigator.popUntil(context, (r) => r.),
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = words[currentIndex]['ko'] ?? '';
    return Scaffold(
      appBar: AppBar(title: const Text('Contrarreloj')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('⏳ Tiempo: $secondsLeft',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Text('✅ $correct    ❌ $incorrect',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 32),
            Text(word,
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            TextField(
              controller: _controller,
              onChanged: (val) => userAnswer = val,
              decoration:
                  const InputDecoration(hintText: 'Traducción en español'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => validateAnswer(),
              child: const Text('Validar'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('🚪 Abandonar partida'),
            )
          ],
        ),
      ),
    );
  }
}
