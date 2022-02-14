import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextInputType textInputType;
  final IconData icon;
  final String label;
  final Function(String) onChanged;
  final String? errorText;

  const InputField({
    Key? key,
    required this.textInputType,
    required this.icon,
    required this.label,
    required this.onChanged,
    required this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),),
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        errorText: errorText,
      ),
      onChanged: onChanged,
    );
  }
}
