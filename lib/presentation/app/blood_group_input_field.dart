import 'package:flutter/material.dart';

class BloodGroupInputField extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function(String?) onChanged;
  final String? errorText;

  const BloodGroupInputField({
    Key? key,
    required this.icon,
    required this.label,
    required this.onChanged,
    required this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        labelText: label,
        errorText: errorText,
      ),
      items: <String>[
        'A+',
        'A-',
        'B+',
        'B-',
        'O+',
        'O-',
        'AB+',
        'AB-',
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}