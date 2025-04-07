import 'package:flutter/material.dart';
import 'package:scorevault/views/widgets/texts/sv_standard_text.dart';

class SvStandardButton extends StatelessWidget {
  final String text;
  final Function function;
  final Color color;
  final Color textColor;
  const SvStandardButton({super.key, required this.text, required this.function, required this.color, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          enableFeedback: true,
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            function();
          },
          child: Center(child: Padding(
            padding: const EdgeInsets.only(
              top: 24,bottom: 24,left: 16,right: 16
            ),
            child: SvStandardText(
              text: text,
              textColor: textColor,
              size: 16,
            )
          )),
        ),
      ),
    );
  }
}
