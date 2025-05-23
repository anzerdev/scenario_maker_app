import 'package:flutter/material.dart';

class Stub extends StatelessWidget {
  const Stub({
    required this.text,
    required this.icon,
    required this.iconColor,
    super.key,
  });
 
  final String text;
  final IconData icon;
  final Color? iconColor; 
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 72,
            color: iconColor,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center, // выравниваем текст по центру
          ),
        ],
      ),
    );
  }
}