import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnfirebase/adminScreen/pending.dart';
import 'package:learnfirebase/registerScreen/login.dart';
import 'package:learnfirebase/shared/setting_card.dart';
import 'package:learnfirebase/userScreens/testpage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _launchUrl(phoneNumber) async {
    final Uri _url = Uri.parse('tel:$phoneNumber}');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> _launchMessage(phoneNumber) async {
    final Uri _url = Uri.parse('sms:$phoneNumber}');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: LoadingAnimationWidget.discreteCircle(
                size: 32,
                color: Colors.white,
                secondRingColor: Colors.indigo,
                thirdRingColor: Colors.pink.shade400),
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListView(
                  children: [
                    const Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'myFont',
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.notifications_none_outlined,
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/user.svg",
                            height: 50,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData['fullname'],
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'myFont',
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Text(
                                'Show Profile',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            const Expanded(
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Upload Your Room',
                                      style: TextStyle(
                                        fontFamily: 'myFont',
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "it's simple to get set up and start earning.",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black87),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            //
                            SvgPicture.asset(
                              "assets/icons/home-profile.svg",
                              height: 60,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 47,
                            child: profileButton('Call Me', () async {
                              await _launchUrl(userData['phone']);
                            }, Icons.phone_outlined, Colors.black54),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 47,
                            child: profileButton('Message Me', () async {
                              await _launchMessage(userData['phone']);
                            }, Icons.message_outlined, Colors.indigo.shade400),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black54),
                      ),
                      child: Column(
                        children: [
                          profileCard('Name', userData['fullname']),
                          const Divider(
                            thickness: 1,
                            color: Colors.black54,
                          ),
                          profileCard('Email', userData['email']),
                          const Divider(
                            thickness: 1,
                            color: Colors.black54,
                          ),
                          profileCard('Phone', "(+216) ${userData['phone']}"),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SettingCard(
                        text: 'Get Help', icon: Icons.find_in_page_outlined),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (conetxt)=>TestPageHere()));
                      },
                      child: const SettingCard(
                          text: 'About Us',
                          icon: Icons.security_update_warning_outlined),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        if (!mounted) return;
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                            (route) => false);
                      },
                      child: const SettingCard(
                          text: 'Log Out', icon: Icons.logout_rounded),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SettingCard(
                        text: 'Delete Account',
                        icon: Icons.delete_outline_rounded),
                  ],
                ),
              ),
            ),
          );
  }

  Widget profileButton(
      String text, VoidCallback onPressed, IconData icon, Color colors) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(colors),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
      icon: Icon(
        icon,
        size: 22,
      ),
      label: Text(
        text,
        style: const TextStyle(fontSize: 14, fontFamily: 'myFont'),
      ),
    );
  }

  Widget profileCard(String title, String text) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 10),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'myFont',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
