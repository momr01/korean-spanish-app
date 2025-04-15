import 'package:flutter/material.dart';
import 'package:korean_spanish_app/features/auth/register/screens/register_screen.dart';
import 'package:korean_spanish_app/features/home/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _goToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, animation, __, child) {
          final curved =
              CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          return FadeTransition(opacity: curved, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.language_rounded,
                    size: 72, color: isDark ? Colors.white : Colors.deepPurple),
                const SizedBox(height: 24),
                Text("Bienvenido de nuevo",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black)),
                const SizedBox(height: 8),
                Text("Inicia sesión para continuar",
                    style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white54 : Colors.black54)),
                const SizedBox(height: 32),
                TextField(
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)))),
                const SizedBox(height: 16),
                TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)))),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _goToHome(context),
                  child: const Text("Iniciar sesión",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const RegisterScreen(),
                        transitionsBuilder: (_, animation, __, child) {
                          final curved = CurvedAnimation(
                              parent: animation, curve: Curves.easeInOutBack);
                          return SlideTransition(
                              position: Tween(
                                      begin: const Offset(1, 0),
                                      end: Offset.zero)
                                  .animate(curved),
                              child: child);
                        },
                      ),
                    );
                  },
                  child: const Text("¿No tenés cuenta? Registrate"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
