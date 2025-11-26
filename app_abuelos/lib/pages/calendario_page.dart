import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/// Pantalla de Calendario con selección de día y estilos accesibles.
class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario', style: TextStyle(fontSize: 28)),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            availableGestures: AvailableGestures.all,
            rowHeight: 54,
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle:
                  TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            calendarStyle: const CalendarStyle(
              weekendTextStyle: TextStyle(fontSize: 20),
              defaultTextStyle: TextStyle(fontSize: 20),
              selectedTextStyle: TextStyle(fontSize: 20, color: Colors.white),
              selectedDecoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              todayDecoration:
                  BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _selectedDay == null
                  ? 'Selecciona una fecha'
                  : 'Fecha seleccionada: ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}