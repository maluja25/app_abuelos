import 'package:flutter/material.dart';

/// Pantalla de Ayuda con un único botón grande que envía una alerta.
class AyudaPage extends StatelessWidget {
  const AyudaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ayuda',
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            minimumSize: const Size(280, 120),
            textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          icon: const Icon(Icons.warning, size: 48),
          label: const Text('Enviar Alerta'),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Alerta enviada', style: TextStyle(fontSize: 20)),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
      ),
    );
  }
}