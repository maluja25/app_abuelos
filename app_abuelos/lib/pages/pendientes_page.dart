import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Modelo simple de pendiente.
class TodoItem {
  TodoItem({required this.title, this.done = false});

  final String title;
  bool done;

  Map<String, dynamic> toJson() => {
        'title': title,
        'done': done,
      };

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      TodoItem(title: json['title'] ?? '', done: json['done'] ?? false);
}

/// Pantalla de Pendientes con lista editable y persistencia local.
class PendientesPage extends StatefulWidget {
  const PendientesPage({super.key});

  @override
  State<PendientesPage> createState() => _PendientesPageState();
}

class _PendientesPageState extends State<PendientesPage> {
  List<TodoItem> _todos = [];
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs!.getString('todos') ?? '[]';
    final list = (jsonDecode(raw) as List)
        .map((e) => TodoItem.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    setState(() => _todos = list);
  }

  Future<void> _save() async {
    final raw = jsonEncode(_todos.map((e) => e.toJson()).toList());
    await _prefs?.setString('todos', raw);
  }

  Future<void> _addTodo() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuevo pendiente', style: TextStyle(fontSize: 24)),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Escribe el pendiente'),
          style: const TextStyle(fontSize: 22),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar', style: TextStyle(fontSize: 20)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
            child: const Text('Guardar', style: TextStyle(fontSize: 22)),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() => _todos.add(TodoItem(title: result)));
      await _save();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pendiente agregado', style: TextStyle(fontSize: 18)),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _toggle(int index) async {
    setState(() => _todos[index].done = !_todos[index].done);
    await _save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendientes', style: TextStyle(fontSize: 28)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(64),
                textStyle: const TextStyle(fontSize: 28),
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
              ),
              onPressed: _addTodo,
              icon: const Icon(Icons.add, size: 40),
              label: const Text('Agregar pendiente'),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _todos.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = _todos[index];
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      decoration: item.done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color:
                          item.done ? Colors.grey.shade700 : Colors.black,
                    ),
                  ),
                  leading: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: item.done,
                      onChanged: (_) => _toggle(index),
                    ),
                  ),
                  onTap: () => _toggle(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}