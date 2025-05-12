import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hintText;
  final bool isObscure;
  final bool showToggle;
  final VoidCallback? onToggle;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.hintText,
    this.isObscure = false,
    this.showToggle = false,
    this.onToggle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          obscureText: isObscure,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
            suffixIcon: showToggle
                ? IconButton(
                    icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: onToggle,
                  )
                : null,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
