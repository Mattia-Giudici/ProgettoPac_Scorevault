import 'package:flutter/material.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';

class SvAuthtextfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final Function function;
  final IconButton button;
  
  const SvAuthtextfieldWidget({
    super.key,
    required this.controller,
    required this.hinttext, required this.function, required this.button,
  });

  @override
  Widget build(BuildContext context) {
      TextStyle style = SvBoldText.getTextStyle(size: 16, textColor: Theme.of(context).colorScheme.onSurface);
    return TextFormField(
      controller: controller,
      style: style,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintStyle:style,
        labelStyle: style,
        hintText: hinttext,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 24,
        ),
      ),
    );
  }
}
