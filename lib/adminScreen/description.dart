import 'dart:convert';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:learnfirebase/post/add_review.dart';
import 'package:learnfirebase/post/reviews.dart';
import 'package:learnfirebase/shared/custombutton.dart';
import 'package:learnfirebase/userscreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

class Description extends StatefulWidget {
  final Map postDetails;
  final List images;
  const Description({
    super.key,
    required this.postDetails,
    required this.images,
  });

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  int activeIndex = 0;
  bool isExpanded = false;
  Map userData = {};
  bool isLoading = true;

  sendMessage({required String title, required String message}) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAALB_7DVI:APA91bHW8JbWqCTCZDHdB1867HDLG0vi_NmfvaMGo13Ca2qjHqyAUcFYKF7hK9Ed3ydU1tUPEIpCcn3DigfazOWhZ5yjPj2v071CZ2mqWbQfBPWAvIGsDZC3607rKMBRlzb2lpg7_Cck'
    };
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = {
      "to": widget.postDetails['token'],
      "notification": {
        "title": title,
        "body": message,
        // "mutable_content": true,
        // "sound": "Tri-tone"
      }
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }

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
    return SafeArea(
      child: isLoading
          ? SafeArea(
              child: Scaffold(
                body: Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      size: 32,
                      color: Colors.black,
                      secondRingColor: Colors.indigo,
                      thirdRingColor: Colors.pink.shade400),
                ),
              ),
            )
          : Scaffold(
              body: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.25,
                              viewportFraction: 1,
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              },
                            ),
                            itemCount: widget.images.length,
                            itemBuilder: (context, index, realIndex) {
                              return Image.network(
                                widget.images[index]['url'],
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              );
                            },
                          ),
                          Positioned(
                            bottom: 15,
                            right: 15,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black87),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 12.0),
                                child: Text(
                                  "${activeIndex + 1} / ${widget.images.length}",
                                  style: const TextStyle(
                                      fontFamily: 'myFont',
                                      color: Colors.white,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 18,
                              left: 15,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Entire house in ${widget.postDetails['location']}",
                                  style: const TextStyle(
                                      fontSize: 26, fontFamily: 'myFont'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Published on ${DateFormat('yMMMMd').format(widget.postDetails['datePublished'].toDate())}",
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "This house for ${widget.postDetails['categories']} ",
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
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
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Entire house hosted by ${widget.postDetails['hosted_name']}",
                                        style: const TextStyle(
                                            fontSize: 22, fontFamily: 'myFont'),
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/user.svg",
                                      height: 51,
                                      color: Colors.indigo.shade800,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width *
                                          0.27,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.black45)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            child: SvgPicture.asset(
                                              "assets/icons/room.svg",
                                              height: 40,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              "${widget.postDetails['roomNumber']} rooms",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width *
                                          0.27,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.black45)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            child: SvgPicture.asset(
                                              "assets/icons/bed2.svg",
                                              height: 40,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              "${widget.postDetails['bedNumber']} beds",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width *
                                          0.27,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.black45)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            child: SvgPicture.asset(
                                              "assets/icons/shower.svg",
                                              height: 40,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              widget.postDetails['shower'] ==
                                                      'yes'
                                                  ? "Allowed"
                                                  : 'Not Allowed',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "What this place offer",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'myFont'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    offers(
                                        offerLink:
                                            "assets/icons/refrigerator1.svg",
                                        offerName: "Refrigerator",
                                        offerDb: "refrigirator",
                                        offerDisponibiliity: "yes"),
                                    offers(
                                        offerLink: "assets/icons/oven.svg",
                                        offerName: "Oven",
                                        offerDb: "stove",
                                        offerDisponibiliity: "yes"),
                                    offers(
                                        offerLink: "assets/icons/tv.svg",
                                        offerName: "TV",
                                        offerDb: "tv",
                                        offerDisponibiliity: "yes"),
                                    offers(
                                        offerLink: "assets/icons/wifi.svg",
                                        offerName: "Wifi",
                                        offerDb: "wifi",
                                        offerDisponibiliity: "yes"),
                                    offers(
                                        offerLink:
                                            "assets/icons/fire_extinguisher.svg",
                                        offerName: "Fire Extinguisher",
                                        offerDb: "fire_extinguisher",
                                        offerDisponibiliity: "yes"),
                                    offers(
                                        offerLink: "assets/icons/camera.svg",
                                        offerName: "Security Camera",
                                        offerDb: "security_camera",
                                        offerDisponibiliity: "yes"),
                                    offers(
                                        offerLink: "assets/icons/washing.svg",
                                        offerName: "Washer",
                                        offerDb: "whasher",
                                        offerDisponibiliity: "yes"),
                                    offers(
                                        offerLink: "assets/icons/smoke.svg",
                                        offerName: "Smoke Detector",
                                        offerDb: "smoke_detector",
                                        offerDisponibiliity: "yes"),
                                    offers(
                                        offerLink: "assets/icons/garage.svg",
                                        offerName: "Garage",
                                        offerDb: "garage",
                                        offerDisponibiliity: "yes"),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
// =====================================
                                widget.postDetails['uid'] ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? const SizedBox(
                                        width: 5,
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black26),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AddReview(
                                                        notifToken:
                                                            widget.postDetails[
                                                                'token'],
                                                        postId:
                                                            widget.postDetails[
                                                                'docId'], postOwnerId: widget.postDetails['uid'],)));
                                          },
                                          style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              foregroundColor:
                                                  MaterialStateProperty.all<Color>(
                                                      Colors.black),
                                              backgroundColor:
                                                  MaterialStateProperty.all<Color>(
                                                      Colors.white),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                          child: const Text(
                                            'Add Your Review',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),

                                const Gap(20),

                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black26),
                                      borderRadius: BorderRadius.circular(12)),
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Reviews(
                                                    postDetails:
                                                        widget.postDetails,
                                                    postId: widget
                                                        .postDetails['docId'],
                                                  )));
                                    },
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    child: const Text(
                                      'Show All Reviews',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
// ==================================
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "About this place",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'myFont'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.postDetails['description'],
                                  maxLines: isExpanded ? 1000 : 6,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      height: 1.5,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: Text(
                                    isExpanded ? "Show less " : "Show more ",
                                    style: const TextStyle(
                                        fontSize: 16.5,
                                        fontFamily: 'myFont',
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: widget.postDetails['uid'] ==
                      FirebaseAuth.instance.currentUser!.uid
                  ? const SizedBox(
                      height: 5,
                    )
                  : BottomAppBar(
                      height: MediaQuery.of(context).size.height * 0.085,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        child: userData['role'] == 'user'
                            ? Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "${widget.postDetails['price']} month",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        DateFormat('yMMMd').format(widget
                                            .postDetails['datePublished']
                                            .toDate()),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.065,
                                      child: CustomButton(
                                          onPressed: () {}, text: "Reserve"))
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    widget.postDetails['status'] != 'pending'
                                        ? MainAxisAlignment.center
                                        : MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      String newNotifId = const Uuid().v1();
                                      await sendMessage(
                                          title: 'Failed',
                                          message:
                                              'We regret to inform you that your post has not met our publication criteria and has been rejected. We appreciate your submission and try to add new one.');

                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(widget.postDetails['uid'])
                                          .collection('notifications')
                                          .doc(newNotifId)
                                          .set({
                                        'notifId': newNotifId,
                                        'notifSender': userData['fullname'],
                                        'notifBody':
                                            'We regret to inform you that your post has not met our publication criteria and has been rejected. We appreciate your submission and try to add new one.',
                                        'notifDate': DateTime.now(),
                                        'token': widget.postDetails['token'],
                                      });

                                      // ignore: use_build_context_synchronously
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        title: 'Done',
                                        text: 'Post deleted!',
                                        onConfirmBtnTap: () async {
                                          setState(() {
                                            FirebaseFirestore.instance
                                                .collection('posts')
                                                .doc(
                                                    widget.postDetails['docId'])
                                                .update({
                                              'status': 'rejected',
                                            });
                                          });
                                          if (!mounted) return;
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const UserScreen()));
                                        },
                                      );
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        CupertinoIcons.delete,
                                        color: Colors.red,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  widget.postDetails['status'] != 'pending'
                                      ? const SizedBox(
                                          child: Text(
                                            "You can Delete This Post",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            String newNotifId =
                                                const Uuid().v1();
                                            sendMessage(
                                                title: 'Succes',
                                                message:
                                                    'Thank you for your submission. Your new post has been successfully received and added to our platform. We appreciate your contribution!');
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(widget.postDetails['uid'])
                                                .collection('notifications')
                                                .doc(newNotifId)
                                                .set({
                                              'notifId': newNotifId,
                                              'notifSender':
                                                  userData['fullname'],
                                              'notifBody':
                                                  'Thank you for your submission. Your new post has been successfully received and added to our platform. We appreciate your contribution!',
                                              'notifDate': DateTime.now(),
                                              'token':
                                                  widget.postDetails['token'],
                                            });

                                            setState(() {
                                              FirebaseFirestore.instance
                                                  .collection('posts')
                                                  .doc(widget
                                                      .postDetails['docId'])
                                                  .update({
                                                'status': 'approved',
                                              });
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              CupertinoIcons
                                                  .checkmark_alt_circle,
                                              color: Colors.green,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                      ),
                    ),
            ),
    );
  }

  Widget offers(
      {required String offerLink,
      required String offerName,
      required String offerDb,
      required String offerDisponibiliity}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          SvgPicture.asset(
            offerLink,
            height: 35,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            offerName,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                decoration: widget.postDetails[offerDb] == offerDisponibiliity
                    ? TextDecoration.none
                    : TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }
}
