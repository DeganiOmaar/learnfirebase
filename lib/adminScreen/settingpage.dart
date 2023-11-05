import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnfirebase/shared/setting_card.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'myFont',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SettingCard(
                text: 'Terms of services', icon: CupertinoIcons.book_circle),
            SizedBox(
              height: 10,
            ),
            SettingCard(
                text: 'Privacy Policy',
                icon: CupertinoIcons.arrow_right_arrow_left_circle),
            SizedBox(
              height: 10,
            ),
            SettingCard(
                text: 'Cookies Policy', icon: CupertinoIcons.chart_bar_circle),
            SizedBox(
              height: 10,
            ),
            SettingCard(
                text: 'Community Standars',
                icon: CupertinoIcons.check_mark_circled),
            SizedBox(
              height: 10,
            ),
            SettingCard(text: 'About', icon: CupertinoIcons.info_circle),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
}
