import 'package:flutter/material.dart';

class AjustesPage extends StatefulWidget {
  const AjustesPage({super.key});

  @override
  State<AjustesPage> createState() => _AjustesPageState();
}

class _AjustesPageState extends State<AjustesPage> {
  bool _altoContraste = true;
  bool _textoGrande = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes', style: TextStyle(fontSize: 28)),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          SwitchListTile(
            value: _altoContraste,
            onChanged: (v) => setState(() => _altoContraste = v),
            title: const Text('Modo alto contraste',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            subtitle: const Text('Colores intensos para mejor visibilidad',
                style: TextStyle(fontSize: 18)),
          ),
          const Divider(),
          SwitchListTile(
            value: _textoGrande,
            onChanged: (v) => setState(() => _textoGrande = v),
            title: const Text('Texto muy grande',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            subtitle: const Text('Aumenta tamaños de fuente en la app',
                style: TextStyle(fontSize: 18)),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(64),
                backgroundColor: Colors.blueGrey.shade800,
                foregroundColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ajustes guardados',
                        style: TextStyle(fontSize: 18)),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.save, size: 32),
              label: const Text('Guardar'),
            ),
          ),
        ],
      ),
    );
  }
}