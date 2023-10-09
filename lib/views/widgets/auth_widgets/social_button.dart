import 'package:flutter/material.dart';
import 'package:medica/config/config.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.social});

  final String social;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: SizedBox(
        height: Config.screenHeight! * 0.06,
        width: Config.widthSize * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              'assets/images/$social.png',
              width: 30,
              height: 30,
            ),
            Text(
              social.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
