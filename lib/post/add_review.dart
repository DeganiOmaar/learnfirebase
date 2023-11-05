import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:learnfirebase/userscreen.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

class AddReview extends StatefulWidget {
  final String notifToken;
  final String postId;
  final String postOwnerId;
  const AddReview({super.key, required this.notifToken, required this.postId, required this.postOwnerId});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  TextEditingController reviewController = TextEditingController();

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
      "to": widget.notifToken,
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

  sendReviews() async {
    String newReviewId = const Uuid().v1();
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.postId)
        .collection("reviews")
        .doc(newReviewId)
        .set({
      'reviewId': newReviewId,
      'reviewIdSender': userData['fullname'],
      'reviewIdBody': reviewController.text,
      'reviewIdDate': DateTime.now(),
      'token': widget.notifToken,
    });
  }
    sendReviewsToNotif( ) async {
    String newReviewId = const Uuid().v1();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userData['uid'])
        .collection("notifications")
        .doc(newReviewId)
        .set({
      'reviewId': newReviewId,
      'reviewIdSender': userData['fullname'],
      'reviewIdBody': reviewController.text,
      'reviewIdDate': DateTime.now(),
      'token': widget.notifToken,
    });
  }

  sendNotif() async {
    String newNotifId = const Uuid().v1();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.postOwnerId)
        .collection("notifications")
        .doc(newNotifId)
        .set({
      'notifId': newNotifId,
      'notifSender': userData['fullname'],
      'notifBody':
          "${userData['fullname']} added a new review to your post. you can check it now!",
      'notifDate': DateTime.now(),
      'token': widget.notifToken,
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  const Text(
                    "Review This Post",
                    style: TextStyle(fontSize: 22, fontFamily: 'myFont'),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/icons/review.svg",
                    height: 28,
                  )
                ],
              ),
              const Gap(30),
              const Text(
                "Review",
                style: TextStyle(fontSize: 16, color: Colors.black45),
              ),
              const Gap(10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.indigo,
                      width: 0.9, // Border width
                    ),
                    borderRadius: BorderRadius.circular(15), // Border radius
                  ),
                  height: 300,
                  child: TextField(
                    maxLines: null, // Allows text to wrap to the next line
                    controller: reviewController,
                    decoration: const InputDecoration(
                      hintText: "You can add your review here...",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(12)),
                    child: ElevatedButton(
                      onPressed: () async {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          title: 'Sure!',
                          text: 'Want To cancel this Review?',
                          cancelBtnText: 'Cancel',
                          confirmBtnColor: Colors.green,
                          confirmBtnText: 'Okay',
                          onConfirmBtnTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserScreen()),
                                (route) => false);
                          },
                          onCancelBtnTap: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.indigo),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)))),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await sendNotif();
                          await sendReviews();
                          sendMessage(
                              title: 'New Review',
                              message: reviewController.text);
                          // ignore: use_build_context_synchronously
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Review Added Successfully!',
                              onConfirmBtnTap: () {
                                Navigator.of(context).pop();
                              });

                          print(
                              "Succesfuly Bruda ===================================================");
                          reviewController.clear();
                        } on Exception catch (e) {
                          // ignore: use_build_context_synchronously
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              text: 'Review Not Added!',
                              onConfirmBtnTap: () {
                                Navigator.of(context).pop();
                              });
                          print(
                              "Not Added ${e.toString()} ==========================================================");
                        }
                      },
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.indigo),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)))),
                      child: const Text(
                        '  Post  ',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
