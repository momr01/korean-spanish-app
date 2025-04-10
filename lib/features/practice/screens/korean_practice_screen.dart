import 'package:flutter/material.dart';
import 'package:korean_spanish_app/common/widgets/loader.dart';
import 'package:korean_spanish_app/features/practice/widgets/option_practice_screen.dart';
import 'package:korean_spanish_app/models/word/word.dart';
import 'package:korean_spanish_app/providers/word_provider.dart';
import 'package:provider/provider.dart';

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

class KoreanWordItem {
  final String korean;
  final String spanish;
  bool isRevealed;

  KoreanWordItem(
      {required this.korean, required this.spanish, this.isRevealed = false});
}*/

class KoreanPracticeScreen extends StatefulWidget {
  // final List<Word> words;
  const KoreanPracticeScreen({super.key});

  @override
  State<KoreanPracticeScreen> createState() => _KoreanPracticeScreenState();
}

class _KoreanPracticeScreenState extends State<KoreanPracticeScreen> {
/*  final List<String> wordsKo = const [
    '사랑',
    '친구',
    '학교',
    '음식',
    '행복',
    '책',
    '고양이',
  ];

  List<KoreanWordItem> wordItems = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAndConvertWords();
  }

  Future<void> fetchAndConvertWords() async {
    final wordProvider = Provider.of<WordProvider>(context, listen: false);
    await wordProvider.apiService.fetchWords();

    setState(() {
      wordItems = wordProvider.words
          .map((w) => KoreanWordItem(
              korean: w.korean, spanish: w.spanish, isRevealed: false))
          .toList();
      wordItems.shuffle();
      isLoading = false;
    });
  }*/

  // @override
  @override
  Widget build(BuildContext context) {
    //   final isDark = Theme.of(context).brightness == Brightness.dark;

    // final List<KoreanWordItem> wordItems = [
    //   KoreanWordItem(korean: '사랑', spanish: 'Amor'),
    //   KoreanWordItem(korean: '친구', spanish: 'Amigo'),
    //   KoreanWordItem(korean: '학교', spanish: 'Escuela'),
    //   KoreanWordItem(korean: '음식', spanish: 'Comida'),
    //   KoreanWordItem(korean: '행복', spanish: 'Felicidad'),
    //   KoreanWordItem(korean: '책', spanish: 'Libro'),
    //   KoreanWordItem(korean: '고양이', spanish: 'Gato'),
    // ];
    // List<KoreanWordItem> wordItems = [];

    // setState(() {
    // final words = Provider.of<WordProvider>(context).words;
    // words.map((word) => wordItems
    //     .add(KoreanWordItem(korean: word.korean, spanish: word.spanish)));
    // });

    /* return Scaffold(
      appBar: AppBar(title: const Text('🈶 Coreano')),
      floatingActionButton: _buildBackButton(context, isDark),
      /* body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: wordsKo.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: isDark ? Colors.deepPurple.shade700 : Colors.deepPurple.shade100,
            child: ListTile(
              title: Center(
                child: Text(
                  wordsKo[index],
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),*/
      body: isLoading
          ? const Loader()
          : ListView.builder(
              padding: const EdgeInsets.only(top: 16, bottom: 100),
              itemCount: wordItems.length,
              itemBuilder: (context, index) {
                final item = wordItems[index];
                // itemCount: words.length,
                // itemBuilder: (context, index) {
                //   final item = words[index];

                return StatefulBuilder(
                  builder: (context, setInnerState) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          setInnerState(() {
                            item.isRevealed = !item.isRevealed;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.korean,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              AnimatedCrossFade(
                                firstChild: const SizedBox.shrink(),
                                secondChild: Text(
                                  item.spanish,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                crossFadeState: item.isRevealed
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 300),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /*  child: Padding(
  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.korean,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
            child: Icon(
              item.isRevealed ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              key: ValueKey(item.isRevealed),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      AnimatedCrossFade(
        firstChild: const SizedBox.shrink(),
        secondChild: Text(
          item.spanish,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        crossFadeState: item.isRevealed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
      ),
    ],
  ),
),*/
                    );
                  },
                );
              },
            ),
    );*/

    return const OptionPracticeScreen(hideKorean: false);
  }
}
