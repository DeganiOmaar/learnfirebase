// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';

class ProfileCard extends StatefulWidget {
  String title;
  String text;
  ProfileCard({super.key, required this.text, required this.title});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 10),
      child: Row(
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'myFont',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            widget.text,
            style: const TextStyle(
                fontSize: 16, color: Color.fromARGB(1, 25, 25, 25)),
          )
        ],
      ),
    );
  }
}
