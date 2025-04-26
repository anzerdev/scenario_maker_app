import 'package:flutter/material.dart';

class ScenarioDescriptionTextField extends StatelessWidget {
  const ScenarioDescriptionTextField({
    required this.title, 
    required this.hintText, 
    required this.controller,
    required this.validator,
    super.key,});

  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextFormField(
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
          )  
        ),
      ]
    );
  }
}