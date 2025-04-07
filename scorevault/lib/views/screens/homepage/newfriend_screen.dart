import 'package:flutter/material.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/views/screens/homepage/homepag_screen.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';

class NewfriendScreen extends StatelessWidget {
  const NewfriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: SvBoldText(
          text: "Aggiungi amico",
          size: 24,
          textColor: AppColors.lightGrey,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePageScreen()),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.lightSurface,
          ),
        ),
      ),
    );
  }
}
