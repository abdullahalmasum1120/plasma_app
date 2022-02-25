import 'package:flutter/material.dart';

class BloodGroupInputField extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function(String?) onChanged;
  final String? errorText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;

  const BloodGroupInputField({
    Key? key,
    required this.icon,
    required this.label,
    required this.onChanged,
    this.errorText,
    this.validator,
    this.autoValidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      autovalidateMode: autoValidateMode,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(right: 12.0),
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
