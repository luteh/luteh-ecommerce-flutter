import 'package:flutter/material.dart';

import '../style/sizes.dart';

class RoundedTextField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String labelText;
  final bool isPasswordField;
  final TextInputType? keyboardType;
  final int maxLines;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final BorderRadius? borderRadius;
  const RoundedTextField({
    super.key,
    required this.onChanged,
    required this.labelText,
    this.isPasswordField = false,
    this.keyboardType,
    this.maxLines = 1,
    this.floatingLabelBehavior,
    this.borderRadius,
  });

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.isPasswordField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        widget.onChanged(value);
      },
      maxLines: widget.maxLines,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.labelText,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        border: OutlineInputBorder(
          borderRadius:
              widget.borderRadius ?? BorderRadius.circular(Sizes.radius50),
        ),
        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
