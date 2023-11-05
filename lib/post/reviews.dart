import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Reviews extends StatefulWidget {
  final Map postDetails;
  final String postId;
  const Reviews({super.key, required this.postDetails, required this.postId});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Align(
                alignment: Alignment.topLeft,
                child: Icon(Icons.arrow_back),
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/star5.svg",
                  height: 26,
                  color: Colors.yellow.shade700,
                ),
                SvgPicture.asset(
                  "assets/icons/star5.svg",
                  height: 26,
                  color: Colors.yellow.shade700,
                ),
                const Gap(20),
                const Text(
                  "All Reviews",
                  style: TextStyle(fontSize: 22, fontFamily: 'myFont'),
                ),
                const Gap(20),
                SvgPicture.asset(
                  "assets/icons/star5.svg",
                  height: 26,
                  color: Colors.yellow.shade700,
                ),
                SvgPicture.asset(
                  "assets/icons/star5.svg",
                  height: 26,
                  color: Colors.yellow.shade700,
                ),
              ],
            ),
            const Gap(30),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(widget.postId)
                    .collection('reviews')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.discreteCircle(
                          size: 32,
                          color: Colors.black,
                          secondRingColor: Colors.indigo,
                          thirdRingColor: Colors.pink.shade400),
                    );
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/avatar.svg",
                                      height: 34,
                                    ),
                                  ),
                                ),
                                const Gap(15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['reviewIdSender'],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Gap(3),
                                    Text(
                                      DateFormat('yMMMd').format(
                                          data['reviewIdDate'].toDate()),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black38),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const Gap(10),
                            Text(
                              data['reviewIdBody'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.black87),
                            ),
                            const Gap(10),
                            const Divider(
                              thickness: 1,
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
