import 'package:flutter/material.dart';
import 'helper/constants.dart';

// 1
class homePage extends StatelessWidget {
  // 2
  final _pinCodeController = TextEditingController();

  // 3
  @override
  Widget build(BuildContext context) {
    // 3a
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: bigRadius,
      child: appLogo,
    );

    // 3b

    // 3c
    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(listPageTag);
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const StadiumBorder(
              side: BorderSide(
            color: appGreyColor,
            style: BorderStyle.solid,
          ))),
        ),
        child:
            const Text(loginButtonText, style: TextStyle(color: Colors.white)),
      ),
    );

    // 3d
    return Scaffold(
      backgroundColor: appDarkGreyColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: bigRadius),
            const SizedBox(height: buttonHeight),
            loginButton
          ],
        ),
      ),
    );
  }
}
