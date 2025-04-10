import 'package:flutter/material.dart';
import 'package:korean_spanish_app/features/words/screens/custom_keyboard_screen.dart';

class AddWordScreen extends StatefulWidget {
  const AddWordScreen({super.key});

  @override
  State<AddWordScreen> createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  String koreanWord = '';
  String spanishWord = '';

  Future<void> _navigateAndEdit(bool isKorean) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CustomKeyboardScreen(
          initialText: isKorean ? koreanWord : spanishWord,
          isKorean: isKorean,
        ),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        if (isKorean) {
          koreanWord = result;
        } else {
          spanishWord = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: const Text('➕ Agregar palabra'),
        backgroundColor: isDark ? Colors.deepPurple[900] : Colors.deepPurple,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nueva palabra',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Campo coreano (como botón)
            GestureDetector(
              onTap: () => _navigateAndEdit(true),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(text: koreanWord),
                  decoration: InputDecoration(
                    hintText: 'Palabra en coreano',
                    prefixIcon: const Icon(Icons.language),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                    fillColor: isDark ? Colors.white10 : Colors.grey[100],
                  ),
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Campo español (como botón)
            GestureDetector(
              onTap: () => _navigateAndEdit(false),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(text: spanishWord),
                  decoration: InputDecoration(
                    hintText: 'Traducción en español',
                    prefixIcon: const Icon(Icons.translate),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                    fillColor: isDark ? Colors.white10 : Colors.grey[100],
                  ),
                  style: TextStyle(color: textColor),
                ),
              ),
            ),

            const SizedBox(height: 32),

            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Guardar palabra'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  // Guardar la palabra
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Palabra guardada 🎉'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
