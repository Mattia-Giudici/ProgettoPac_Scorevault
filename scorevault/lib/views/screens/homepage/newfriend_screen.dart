import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';

class NewfriendScreen extends StatelessWidget {
  const NewfriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: SvBoldText(
          text: "Aggiungi amico",
          size: 24,
          textColor: Theme.of(context).colorScheme.onSurface,
        ),
        leading: IconButton(onPressed: (){
          context.push('/home');
        }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
    );
  }
}