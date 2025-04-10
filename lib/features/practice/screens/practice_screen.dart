import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:korean_spanish_app/common/layouts/main_screen.dart';
import 'package:korean_spanish_app/features/practice/screens/spanish_hidden_screen.dart';

class PracticeScreen extends StatefulWidget {
  static const String routeName = '/practice';
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  void fromPracticeToSpanishHidden(context) {
    Navigator.pushNamed(context, SpanishHiddenScreen.routeName);
  }

  void navigateToSpanishHidden() {
    fromPracticeToSpanishHidden(context);
  }

  Widget buildChild() {
    return Center(
      //padding: EdgeInsets.all(10),
      child: Column(
        children: [
          GestureDetector(
            onTap: navigateToSpanishHidden,
            child: Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Center(
                  child: Text(
                "Coreano - Español oculto",
                style: TextStyle(fontSize: 18),
              )),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 300,
            height: 100,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(child: Text("Coreano - Español oculto")),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      child: buildChild(),
      mainTitle: "Practicar",
    );
  }
}
