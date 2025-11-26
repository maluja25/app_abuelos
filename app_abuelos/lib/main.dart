import 'package:flutter/material.dart';
import 'pages/ayuda_page.dart';
import 'pages/pendientes_page.dart';
import 'pages/calendario_page.dart';
import 'widgets/big_button.dart';
import 'pages/ajustes_page.dart';

/// App principal con Material 3 y pantalla de inicio accesible.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AbuelosApp());
}

class AbuelosApp extends StatelessWidget {
  const AbuelosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Abuelos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme: ThemeData.light()
            .textTheme
            .apply(bodyColor: Colors.black, displayColor: Colors.black),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

/// Pantalla principal con tres botones gigantes de alto contraste.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BigButton(
              label: 'Ayuda',
              icon: Icons.warning,
              color: Colors.red.shade700,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AyudaPage()),
                );
              },
            ),
          ),
          Expanded(
            child: BigButton(
              label: 'Pendientes',
              icon: Icons.check_circle,
              color: Colors.green.shade700,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PendientesPage()),
                );
              },
            ),
          ),
          Expanded(
            child: BigButton(
              label: 'Calendario',
              icon: Icons.calendar_month,
              color: Colors.blue.shade700,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CalendarioPage()),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        tooltip: 'Ajustes',
        backgroundColor: Colors.black87,
        child: const Icon(Icons.settings, size: 36, color: Colors.white),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AjustesPage()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}