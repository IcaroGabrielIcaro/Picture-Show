import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String label;
  final String hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final int maxLines;
  final bool isPassword;

  const CustomInput({
    super.key,
    required this.label,
    required this.hintText,
    this.initialValue,
    this.controller,
    this.maxLines = 1,
    this.isPassword = false,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontFamily: 'JosefinSlab',
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        TextFormField(
          controller: widget.controller,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          obscureText: widget.isPassword ? _obscureText : false,
          style: const TextStyle(
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ) : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: const Color.fromARGB(
                  255,
                  123,
                  123,
                  123,
                ).withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: const Color.fromARGB(
                  255,
                  123,
                  123,
                  123,
                ).withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}