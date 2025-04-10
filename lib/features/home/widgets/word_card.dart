import 'package:flutter/material.dart';
import 'package:korean_spanish_app/constants/utils.dart';

class WordCard extends StatefulWidget {
  final String korean;
  final String spanish;
  final bool showAll;
  final bool hideSpanish;
  final bool hideKorean;
  const WordCard(
      {super.key,
      required this.korean,
      required this.spanish,
      this.showAll = true,
      this.hideKorean = false,
      this.hideSpanish = false});

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  bool isVisible = false;

  @override
  void initState() {
    isVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              widget.hideKorean
                  ? isVisible
                      ? capitalizeFirstLetter(widget.korean)
                      : ""
                  : capitalizeFirstLetter(widget.korean),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.hideSpanish
                  ? isVisible
                      ? capitalizeFirstLetter(widget.spanish)
                      : ""
                  : capitalizeFirstLetter(widget.spanish),
              style: TextStyle(
                fontSize: 30,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const Spacer(),
            widget.showAll
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                      size: 30,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
