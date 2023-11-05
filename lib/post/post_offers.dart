// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:learnfirebase/post/upload_image_post.dart';
import 'package:learnfirebase/shared/snackbar.dart';

class PostOffers extends StatefulWidget {
  final String location;
  final String price;
  String? categories;
  final String description;
  final String roomNumber;
  final String bedNumber;
  PostOffers(
      {super.key,
      required this.location,
      required this.price,
      required this.categories,
      required this.description,
      required this.roomNumber,
      required this.bedNumber});

  @override
  State<PostOffers> createState() => _PostOffersState();
}

class _PostOffersState extends State<PostOffers> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String? haveRefrigirator;
  String? haveStove;
  String? haveShower;
  String? haveTv;
  String? haveWifi;
  String? haveSmoke;
  String? haveCamera;
  String? haverWasher;
  String? haveFire;
  String? haveGarage;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Form(
              key: formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    " What this place offers",
                    style: TextStyle(
                        fontFamily: 'myFont',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/refrigerator1.svg",
                            height: 35,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Refrigirator',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const Spacer(),
                          Center(
                            child: DropdownButton<String>(
                              value: haveRefrigirator,
                              elevation: 8,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 18),
                              onChanged: (newValue) {
                                setState(() {
                                  haveRefrigirator = newValue!;
                                });
                              },
                              items: <String>[
                                'yes',
                                'no'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/oven.svg",
                            height: 35,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Oven',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const Spacer(),
                          Center(
                            child: DropdownButton<String>(
                              value: haveStove,
                              elevation: 8,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 18),
                              onChanged: (newValue) {
                                setState(() {
                                  haveStove = newValue!;
                                });
                              },
                              items: <String>[
                                'yes',
                                'no'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/shower.svg",
                            height: 35,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Shower',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const Spacer(),
                          Center(
                            child: DropdownButton<String>(
                              value: haveShower,
                              elevation: 8,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 18),
                              onChanged: (newValue) {
                                setState(() {
                                  haveShower = newValue!;
                                });
                              },
                              items: <String>[
                                'yes',
                                'no'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/tv.svg",
                            height: 35,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'TV',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const Spacer(),
                          Center(
                            child: DropdownButton<String>(
                              value: haveTv,
                              elevation: 8,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 18),
                              onChanged: (newValue) {
                                setState(() {
                                  haveTv = newValue!;
                                });
                              },
                              items: <String>[
                                'yes',
                                'no'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/wifi.svg",
                            height: 35,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Wifi',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const Spacer(),
                          Center(
                            child: DropdownButton<String>(
                              value: haveWifi,
                              elevation: 8,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 18),
                              onChanged: (newValue) {
                                setState(() {
                                  haveWifi = newValue!;
                                });
                              },
                              items: <String>[
                                'yes',
                                'no'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/smoke.svg",
                            height: 35,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Smoke detector',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const Spacer(),
                          Center(
                            child: DropdownButton<String>(
                              value: haveSmoke,
                              elevation: 8,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 18),
                              onChanged: (newValue) {
                                setState(() {
                                  haveSmoke = newValue!;
                                });
                              },
                              items: <String>[
                                'yes',
                                'no'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/camera.svg",
                            height: 35,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Security Camera',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const Spacer(),
                          Center(
                            child: DropdownButton<String>(
                              value: haveCamera,
                              elevation: 8,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 18),
                              onChanged: (newValue) {
                                setState(() {
                                  haveCamera = newValue!;
                                });
                              },
                              items: <String>[
                                'yes',
                                'no'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/washing.svg",
                            height: 35,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Washer',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const Spacer(),
                          Center(
                            child: DropdownButton<String>(
                              value: haverWasher,
                              elevation: 8,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 18),
                              onChanged: (newValue) {
                                setState(() {
                                  haverWasher = newValue!;
                                });
                              },
                              items: <String>[
                                'yes',
                                'no'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/fire_extinguisher.svg",
                            height: 35,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Fire extinguisher',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const Spacer(),
                          Center(
                            child: DropdownButton<String>(
                              value: haveFire,
                              elevation: 8,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 18),
                              onChanged: (newValue) {
                                setState(() {
                                  haveFire = newValue!;
                                });
                              },
                              items: <String>[
                                'yes',
                                'no'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/garage.svg",
                            height: 35,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Garage',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const Spacer(),
                          Center(
                            child: DropdownButton<String>(
                              value: haveGarage,
                              elevation: 8,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 18),
                              onChanged: (newValue) {
                                setState(() {
                                  haveGarage = newValue!;
                                });
                              },
                              items: <String>[
                                'yes',
                                'no'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black38,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black87),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            try {
                              if (haveFire != null &&
                                  haveGarage != null &&
                                  haveRefrigirator != null &&
                                  haveShower != null &&
                                  haveSmoke != null &&
                                  haveStove != null &&
                                  haveTv != null &&
                                  haveWifi != null &&
                                  haverWasher != null &&
                                  haveCamera != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UploadImagesAndPost(
                                                location: widget.location,
                                                price: widget.price,
                                                categories: widget.categories!,
                                                description: widget.description,
                                                roomNumber: widget.roomNumber,
                                                bedNumber: widget.bedNumber,
                                                haveStove: haveStove,
                                                haveRefrigirator:
                                                    haveRefrigirator,
                                                haveShower: haveShower,
                                                haveTv: haveTv,
                                                haveWifi: haveWifi,
                                                haveSmoke: haveSmoke,
                                                haveCamera: haveCamera,
                                                haverWasher: haverWasher,
                                                haveFire: haveFire,
                                                haveGarage: haveGarage)));
                              } else {
                                print(
                                    "========================================================= can't");
                                showSnackBar(context, "LAAMYR");
                              }
                            } catch (e) {
                              print("u can't ");
                            }
                          },
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.indigo),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          child: const Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
