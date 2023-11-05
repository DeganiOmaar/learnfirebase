import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    duration: const Duration(milliseconds: 2000),
    content: Padding(
      padding: const EdgeInsets.only(
          top: 10.0, left: 10.0, right: 10.0, bottom: 30.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/attention.svg",
                    height: 40,
                  ),
                  const Gap(20),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add all information to continue",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Gap(10),
                        Text(
                          "You must complete all required information selections before advancing to the next page.",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                  // const Gap(20),
                  // GestureDetector(
                  //     onTap: () {
                  //       Navigator.of(context).pop();
                  //     },
                  //     child: const Icon(
                  //       CupertinoIcons.xmark_circle,
                  //       color: Colors.black,
                  //     ))
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    // action: SnackBarAction(label: , onPressed: () {}),
  ));
}
