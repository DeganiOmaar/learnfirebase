// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:learnfirebase/userScreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnfirebase/shared/snackbar.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

class UploadImagesAndPost extends StatefulWidget {
  final String location;
  final String price;
  final String categories;
  final String description;
  final String roomNumber;
  final String bedNumber;
  String? haveStove;
  String? haveRefrigirator;
  String? haveShower;
  String? haveTv;
  String? haveWifi;
  String? haveSmoke;
  String? haveCamera;
  String? haverWasher;
  String? haveFire;
  String? haveGarage;
  UploadImagesAndPost(
      {super.key,
      required this.location,
      required this.price,
      required this.categories,
      required this.description,
      required this.roomNumber,
      required this.bedNumber,
      required this.haveStove,
      required this.haveRefrigirator,
      required this.haveShower,
      required this.haveTv,
      required this.haveWifi,
      required this.haveSmoke,
      required this.haveCamera,
      required this.haverWasher,
      required this.haveFire,
      required this.haveGarage});

  @override
  State<UploadImagesAndPost> createState() => _UploadImagesAndPostState();
}

class _UploadImagesAndPostState extends State<UploadImagesAndPost> {
  final List<File> _image = [];
  final picker = ImagePicker();
  File? imgPath;
  String? imgName;
  bool uploading = false;
  late CollectionReference imgRef;
  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image.add(File(pickedFile.path));
        int random = Random().nextInt(9999999);
        imgName = "$random$imgName";
      });
    } else {
      if (!mounted) return;
      showSnackBar(context, "No Image Selected 🖐️");
    }
  }

  Future uploadImamges() async {
    for (var img in _image) {
      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref().child(
          "house_img/${FirebaseAuth.instance.currentUser!.uid}/${Path.basename(img.path)}");
      await storageRef.putFile(img).whenComplete(() async {
        await storageRef.getDownloadURL().then((value) {
          imgRef.add({'url': value});
        });
      });
      // String urll = await storageRef.getDownloadURL();
    }
  }

  String newId = const Uuid().v1();
  Map userData = {};
  bool isLoading = true;

  getData() async {
    // Get data from DB

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

  addPost() async {
    String myNotifToken = await getToken();
    try {
      FirebaseFirestore.instance.collection('posts').doc(newId).set({
        'status': 'pending',
        "docId": newId,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "location": widget.location,
        "price": "${widget.price} dt",
        "description": widget.description,
        "roomNumber": widget.roomNumber,
        "bedNumber": widget.bedNumber,
        "categories": widget.categories,
        "datePublished": DateTime.now(),
        "hosted_name": userData['fullname'],
        "refrigirator": widget.haveRefrigirator,
        "stove": widget.haveStove,
        "shower": widget.haveShower,
        "tv": widget.haveTv,
        "wifi": widget.haveWifi,
        "smoke_detector": widget.haveSmoke,
        "security_camera": widget.haveCamera,
        "whasher": widget.haverWasher,
        "fire_extinguisher": widget.haveFire,
        "garage": widget.haveGarage,
        "token": myNotifToken,
      });
    } catch (e) {
      print(e);
    }
  }

  getToken() async {
    String? mytoken = await FirebaseMessaging.instance.getToken();
    print("============================================");
    print(mytoken);
    return mytoken;
  }

  @override
  void initState() {
    super.initState();
    getData();
    imgRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(newId)
        .collection('images');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                        onTap: () {
                          QuickAlert.show(
                            context: context,
                            onCancelBtnTap: () {
                              Navigator.of(context).pop();
                            },
                            confirmBtnColor: Colors.green.shade500,
                            onConfirmBtnTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UserScreen()));
                            },
                            type: QuickAlertType.confirm,
                            title: 'Really!',
                            text: 'You want to cancel this post',
                          );
                        },
                        child: const Icon(Icons.arrow_back)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Add Some Images",
                    style: TextStyle(
                        // fontFamily: 'myFont',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.indigo,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _image.length + 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return index == 0
                            ? Center(
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                  ),
                                  onPressed: () {
                                    !uploading ? chooseImage() : null;
                                  },
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(_image[index - 1]),
                                      fit: BoxFit.cover),
                                ),
                              );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notice :",
                        style: TextStyle(
                            color: Colors.redAccent.shade400, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "We appreciate your submission. Our team will carefully review your post. If it meets our guidelines, we will publish it for others to see.",
                        style: TextStyle(color: Colors.black54, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black38, width: 0.5),
                    ),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_image.isNotEmpty) {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.confirm,
                            text: 'Do you want to add this post',
                            confirmBtnText: 'Yes',
                            onConfirmBtnTap: () async {
                              Navigator.of(context).pop();
                              setState(() {
                                uploading = true;
                              });
                              await addPost();
                              await uploadImamges().whenComplete(() =>
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const UserScreen())));
                            },
                            cancelBtnText: 'No',
                            onCancelBtnTap: () async {
                              Navigator.of(context).pop();
                            },
                            confirmBtnColor: Colors.green,
                          );
                        } else {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: 'Oops...',
                            text: 'Add Your Informations',
                          );
                        }
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
                            borderRadius: BorderRadius.circular(10),
                          ))),
                      child: const Text(
                        "Add Post",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          uploading
              ? Center(
                  child: Container(
                    width: 180,
                    height: 110,
                    decoration: const BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: LoadingAnimationWidget.discreteCircle(
                                size: 32,
                                color: Colors.white,
                                secondRingColor: Colors.indigo,
                                thirdRingColor: Colors.pink.shade400),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Loading...',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    ));
  }
}
