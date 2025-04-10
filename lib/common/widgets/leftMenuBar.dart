import 'package:flutter/material.dart';
import 'package:korean_spanish_app/features/practice/screens/practice_screen.dart';

class LeftMenuBar extends StatelessWidget {
  const LeftMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    void fromHomeToPractice(context) {
      Navigator.pushNamed(context, PracticeScreen.routeName);
    }

    void navigateToStartPractice() {
      fromHomeToPractice(context);
    }

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const DrawerHeader(
              child: Text('🌐 Menú'),
            ),
            const ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
            ),
            GestureDetector(
              onTap: navigateToStartPractice,
              child: const ListTile(
                leading: Icon(Icons.list_alt_sharp),
                title: Text('Practicar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
