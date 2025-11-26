import 'package:flutter/material.dart';

/// Botón de área completa con texto e ícono grandes, alto contraste y Semantics.
class BigButton extends StatelessWidget {
  const BigButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: color,
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.white24,
          child: SizedBox.expand(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 80, color: Colors.white),
                  const SizedBox(height: 20),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}