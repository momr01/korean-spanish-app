import 'package:flutter/material.dart';

class KoreanKeyboardScreen extends StatefulWidget {
  @override
  _KoreanKeyboardScreenState createState() => _KoreanKeyboardScreenState();
}

class _KoreanKeyboardScreenState extends State<KoreanKeyboardScreen> {
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

  // final List<String> finalConsonants = [
  //   '',
  //   'ㄱ',
  //   'ㄲ',
  //   'ㄳ',
  //   'ㄴ',
  //   'ㄵ',
  //   'ㄶ',
  //   'ㄷ',
  //   'ㄹ',
  //   'ㄺ',
  //   'ㄻ',
  //   'ㄼ',
  //   'ㄽ',
  //   'ㄾ',
  //   'ㄿ',
  //   'ㅀ',
  //   'ㅁ',
  //   'ㅂ',
  //   'ㅄ',
  //   'ㅅ',
  //   'ㅆ',
  //   'ㅇ',
  //   'ㅈ',
  //   'ㅊ',
  //   'ㅋ',
  //   'ㅌ',
  //   'ㅍ',
  //   'ㅎ'
  // ];
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

  void onConsonantTap(String c) {
    setState(() {
      if (currentConsonant.isEmpty) {
        currentConsonant = c;
      } else if (currentVowel.isNotEmpty && currentFinalConsonant.isEmpty) {
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

  void confirmSyllable() {
    setState(() {
      if (currentConsonant.isNotEmpty && currentVowel.isNotEmpty) {
        int base = 0xAC00;
        int choseongIndex = consonants.indexOf(currentConsonant);
        int jungseongIndex = vowels.indexOf(currentVowel);
        // int jongseongIndex = currentFinalConsonant.isNotEmpty
        //     ? consonants.indexOf(currentFinalConsonant) + 1
        //     : 0;
        int jongseongIndex = finalConsonants.indexOf(currentFinalConsonant);
        if (jongseongIndex == -1) jongseongIndex = 0;

        if (choseongIndex != -1 && jungseongIndex != -1) {
          int syllableCode = base +
              (choseongIndex * 21 * 28) +
              (jungseongIndex * 28) +
              jongseongIndex;
          displayText += String.fromCharCode(syllableCode);
        }
      } else {
        displayText += currentConsonant + currentVowel;
      }
      currentConsonant = '';
      currentVowel = '';
      currentFinalConsonant = '';
    });
  }

  void deleteLast() {
    setState(() {
      if (displayText.isNotEmpty) {
        displayText = displayText.substring(0, displayText.length - 1);
      }
    });
  }

  void clearText() {
    setState(() {
      displayText = '';
      currentConsonant = '';
      currentVowel = '';
      currentFinalConsonant = '';
    });
  }

  void insertSpace() {
    setState(() {
      confirmSyllable(); // Confirmamos cualquier sílaba en curso antes de insertar el espacio
      displayText += ' ';
    });
  }

  Widget buildKey(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(label, style: TextStyle(fontSize: 18)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String preview = currentConsonant + currentVowel + currentFinalConsonant;

    return Scaffold(
      appBar: AppBar(title: Text('Hangul Keyboard')),
      body: Column(
        children: [
          SizedBox(height: 16),
          Text('Texto: $displayText', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 30),
          Text('Sí­laba actual: $preview',
              style: TextStyle(fontSize: 20, color: Colors.grey)),
          const SizedBox(height: 20),
          Wrap(
            children: consonants
                .map((c) => buildKey(c, () => onConsonantTap(c)))
                .toList(),
          ),
          Wrap(
            children:
                vowels.map((v) => buildKey(v, () => onVowelTap(v))).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildKey('Confirmar sílaba', confirmSyllable),
              buildKey('Espacio', insertSpace), // ← Nuevo botón de espacio
              buildKey('Borrar', deleteLast),
              buildKey('Reiniciar', clearText),
            ],
          ),
        ],
      ),
    );
  }
}
