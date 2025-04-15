import 'package:flutter/material.dart';
import 'package:korean_spanish_app/features/auth/login/screens/login_screen.dart';
import 'package:korean_spanish_app/features/home/screens/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  void _goToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, animation, __, child) {
          final curved =
              CurvedAnimation(parent: animation, curve: Curves.easeOutQuart);
          return FadeTransition(opacity: curved, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear cuenta"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Registrate",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black)),
              const SizedBox(height: 24),
              TextField(
                  decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 16),
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
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                // onPressed: () => _goToHome(context),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("¿Estás seguro?"),
                      content: const Text(
                          "Se va a crear tu cuenta y serás redirigido al login."),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Cancelar")),
                        TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Confirmar")),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    // Simula creación de usuario y redirige
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Cuenta creada exitosamente")),
                      );
                      await Future.delayed(const Duration(milliseconds: 800));
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const LoginScreen(),
                          transitionsBuilder: (_, animation, __, child) {
                            final curved = CurvedAnimation(
                                parent: animation, curve: Curves.easeOutQuart);
                            return FadeTransition(
                                opacity: curved, child: child);
                          },
                        ),
                      );
                    }
                  }
                },
                child: const Text("Registrarse",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
