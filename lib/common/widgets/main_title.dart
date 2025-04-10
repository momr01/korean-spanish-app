import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  final bool isDark;
  final String text;
  const MainTitle({super.key, required this.isDark, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
      child: Text(
        '✨ $text',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
