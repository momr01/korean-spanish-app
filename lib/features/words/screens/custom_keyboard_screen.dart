import 'package:flutter/material.dart';

/*
class CustomKeyboardScreen extends StatefulWidget {
  final String initialText;
  final bool isKorean;

  const CustomKeyboardScreen({
    super.key,
    required this.initialText,
    required this.isKorean,
  });

  @override
  State<CustomKeyboardScreen> createState() => _CustomKeyboardScreenState();
}

class _CustomKeyboardScreenState extends State<CustomKeyboardScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onKeyTap(String value) {
    setState(() {
      _controller.text += value;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    });
  }

  void _onBackspace() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _controller.text =
            _controller.text.substring(0, _controller.text.length - 1);
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      });
    }
  }

  void _onAccept() {
    Navigator.pop(context, _controller.text);
  }

  List<String> get _keyboardKeys => widget.isKorean
      ? ["ᄀ", "ᄂ", "ᄃ", "ᄅ", "ᄆ", "ᄇ", "ᄉ", "ᄋ", "ᄌ", "ᄎ", "ᄏ", "ᄐ"]
      : ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l"];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(widget.isKorean ? 'Teclado Coreano' : 'Teclado Español'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                style: TextStyle(fontSize: 24, color: textColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark ? Colors.white10 : Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    ..._keyboardKeys.map(
                      (key) => GestureDetector(
                        onTap: () => _onKeyTap(key),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              key,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _onBackspace,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Icon(Icons.backspace, color: Colors.white),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _onAccept,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Icon(Icons.check, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

class CustomKeyboardScreen extends StatefulWidget {
  final String initialText;
  final bool isKorean;

  const CustomKeyboardScreen({
    super.key,
    required this.initialText,
    required this.isKorean,
  });

  @override
  State<CustomKeyboardScreen> createState() => _CustomKeyboardScreenState();
}

class _CustomKeyboardScreenState extends State<CustomKeyboardScreen> {
  String displayText = '';
  String currentConsonant = '';
  String currentVowel = '';
  String currentFinalConsonant = '';

  final List<String> consonants = [
    'ㄱ',
    'ㄲ',
    'ㄴ',
    'ㄷ',
    'ㄸ',
    'ㄹ',
    'ㅁ',
    'ㅂ',
    'ㅃ',
    'ㅅ',
    'ㅆ',
    'ㅇ',
    'ㅈ',
    'ㅉ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ'
  ];
  final List<String> finalConsonants = [
    '',
    'ㄱ',
    'ㄲ',
    'ㄳ',
    'ㄴ',
    'ㄵ',
    'ㄶ',
    'ㄷ',
    'ㄹ',
    'ㄺ',
    'ㄻ',
    'ㄼ',
    'ㄽ',
    'ㄾ',
    'ㄿ',
    'ㅀ',
    'ㅁ',
    'ㅂ',
    'ㅄ',
    'ㅅ',
    'ㅆ',
    'ㅇ',
    'ㅈ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ'
  ];
  final List<String> vowels = [
    'ㅏ',
    'ㅐ',
    'ㅑ',
    'ㅒ',
    'ㅓ',
    'ㅔ',
    'ㅕ',
    'ㅖ',
    'ㅗ',
    'ㅘ',
    'ㅙ',
    'ㅚ',
    'ㅛ',
    'ㅜ',
    'ㅝ',
    'ㅞ',
    'ㅟ',
    'ㅠ',
    'ㅡ',
    'ㅢ',
    'ㅣ'
  ];

  final List<String> spanishKeys = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'Ñ',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  @override
  void initState() {
    super.initState();
    displayText = widget.initialText;
  }

  void onConsonantTap(String c) {
    setState(() {
      if (currentConsonant.isEmpty) {
        currentConsonant = c;
      } else if (currentVowel.isNotEmpty &&
          currentFinalConsonant.isEmpty &&
          finalConsonants.contains(c)) {
        currentFinalConsonant = c;
      } else {
        confirmSyllable();
        currentConsonant = c;
      }
    });
  }

  void onVowelTap(String v) {
    setState(() {
      if (currentConsonant.isNotEmpty && currentVowel.isEmpty) {
        currentVowel = v;
      } else {
        confirmSyllable();
        currentVowel = v;
      }
    });
  }

  void onLetterTap(String l) {
    setState(() {
      displayText += l.toLowerCase();
    });
  }

  void confirmSyllable() {
    if (currentConsonant.isNotEmpty && currentVowel.isNotEmpty) {
      int base = 0xAC00;
      int choseongIndex = consonants.indexOf(currentConsonant);
      int jungseongIndex = vowels.indexOf(currentVowel);
      int jongseongIndex = currentFinalConsonant.isNotEmpty
          ? finalConsonants.indexOf(currentFinalConsonant)
          : 0;

      if (choseongIndex != -1 && jungseongIndex != -1) {
        int syllableCode = base +
            (choseongIndex * 21 * 28) +
            (jungseongIndex * 28) +
            jongseongIndex;
        displayText += String.fromCharCode(syllableCode);
      } else {
        displayText += currentConsonant + currentVowel;
      }
    } else {
      displayText += currentConsonant + currentVowel;
    }

    setState(() {
      currentConsonant = '';
      currentVowel = '';
      currentFinalConsonant = '';
    });
  }

  void deleteLast() {
    if (displayText.isNotEmpty) {
      setState(() {
        displayText = displayText.substring(0, displayText.length - 1);
      });
    }
  }

  void insertSpace() {
    confirmSyllable();
    setState(() {
      displayText += ' ';
    });
  }

  void finishEditing() {
    confirmSyllable();
    Navigator.pop(context, displayText);
  }

  Widget buildKey(String label, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          backgroundColor:
              isDark ? Colors.deepPurple[600] : Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String preview = currentConsonant + currentVowel + currentFinalConsonant;

    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isKorean ? '⌨️ Teclado coreano' : '⌨️ Teclado español'),
        backgroundColor: isDark ? Colors.deepPurple[900] : Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text('Texto actual: $displayText',
                style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 8),
            if (widget.isKorean && preview.isNotEmpty)
              Text('Sí­laba actual: $preview',
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (widget.isKorean) ...[
                      Wrap(
                        children: consonants
                            .map((c) => buildKey(c, () => onConsonantTap(c)))
                            .toList(),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        children: vowels
                            .map((v) => buildKey(v, () => onVowelTap(v)))
                            .toList(),
                      ),
                    ] else ...[
                      // Wrap(
                      //   children: spanishKeys
                      //       .map((l) => buildKey(l, () => onLetterTap(l)))
                      //       .toList(),
                      // ),
                      Column(
                        children: [
                          Wrap(
                            children: spanishKeys
                                .map((l) => buildKey(l, () => onLetterTap(l)))
                                .toList(),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            children: ['Á', 'É', 'Í', 'Ó', 'Ú', 'Ü', 'Ñ']
                                .map((c) => buildKey(c, () => onLetterTap(c)))
                                .toList(),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            children: ['¿', '¡', '.', ',', ';', ':', '?', '!']
                                .map((s) => buildKey(s, () => onLetterTap(s)))
                                .toList(),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                if (widget.isKorean)
                  buildKey('Confirmar sílaba', confirmSyllable),
                buildKey('Espacio', insertSpace),
                buildKey('Borrar', deleteLast),
                buildKey('Confirmar', finishEditing),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
