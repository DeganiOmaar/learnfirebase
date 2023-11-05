// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:learnfirebase/adminScreen/pending.dart';
import 'package:learnfirebase/adminScreen/settingpage.dart';
import 'package:learnfirebase/post/describe_post.dart';
import 'package:learnfirebase/userScreens/home.dart';
import 'package:learnfirebase/userScreens/notifications.dart';
import 'package:learnfirebase/userScreens/profile.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Map userData = {};
  bool isLoading = true;

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = snapshot.data()!;
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  final PageController _pageController = PageController();

  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: LoadingAnimationWidget.discreteCircle(
                  size: 32,
                  color: Colors.black,
                  secondRingColor: Colors.indigo,
                  thirdRingColor: Colors.pink.shade400),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: Padding(
              padding:
                  const EdgeInsets.only(left: 4.0, right: 4, top: 4, bottom: 4),
              child: GNav(
                gap: 8,
                color: Colors.grey,
                activeColor: Colors.indigo,
                curve: Curves.decelerate,
                padding: EdgeInsets.only(bottom: 10, left: 6, right: 6, top: 2),
                onTabChange: (index) {
                  _pageController.jumpToPage(index);
                  setState(() {
                    currentPage = index;
                  });
                },
                tabs: [
                  userData['role'] == 'admin'
                      ? GButton(
                          icon: CupertinoIcons.check_mark_circled,
                          text: 'Confirmed',
                        )
                      : GButton(
                          icon: Icons.home_outlined,
                          text: 'Home',
                        ),
                  userData['role'] == 'admin'
                      ? GButton(
                          icon: CupertinoIcons.timer,
                          text: 'Pending',
                        )
                      : GButton(
                          icon: Icons.notifications_outlined,
                          text: 'Notifications',
                        ),
                  userData['role'] == 'admin'
                      ? GButton(
                          icon: Icons.settings,
                          text: 'Setting',
                        )
                      : GButton(
                          icon: Icons.add_circle_outline_outlined,
                          text: 'Add',
                        ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
              ),
            ),
            body: PageView(
              onPageChanged: (index) {},
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                Home(),
                userData['role'] == 'admin' ? TestPage() : Notfications(),
                userData['role'] == 'admin' ? SettingPage() : AddRoom(),
                Profile(
                    // profileUid: FirebaseAuth.instance.currentUser!.uid,
                    ),
              ],
            ),
          );
  }
}
