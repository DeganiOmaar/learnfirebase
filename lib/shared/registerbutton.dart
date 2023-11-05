import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterButton extends StatelessWidget {
  final String text;
  final String link;
  const RegisterButton({super.key, required this.text, required this.link});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black87),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            SvgPicture.asset(
              link,
              height: 26,
            ),
            const SizedBox(
              width: 50,
            ),
            Center(
              child: Text(
                'Continue with $text',
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
