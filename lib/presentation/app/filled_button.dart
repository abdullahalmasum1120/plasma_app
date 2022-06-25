import 'package:flutter/material.dart';

class MyFilledButton extends StatelessWidget {
  final Widget child;
  final Size? size;
  final Color color;
  final VoidCallback? onTap;

  const MyFilledButton({
    Key? key,
    required this.child,
    this.size = const Size(double.infinity, 0),
    required this.onTap,
    this.color = const Color(0xFFFF2156),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: size,
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onTap,
      child: child,
    );
  }
}
