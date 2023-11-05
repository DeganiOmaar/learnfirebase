// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OffersCard extends StatefulWidget {
  final String link;
  String? haveOrNot;
  final String name;
  OffersCard({
    super.key,
    required this.link,
    required this.haveOrNot,
    required this.name,
  });

  @override
  State<OffersCard> createState() => _OffersCardState();
}

class _OffersCardState extends State<OffersCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          widget.link,
          height: 35,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          widget.name,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        const Spacer(),
        Center(
          child: DropdownButton<String>(
            value: widget.haveOrNot,
            elevation: 8,
            style: const TextStyle(color: Colors.black87, fontSize: 18),
            onChanged: (newValue) {
              setState(() {
                widget.haveOrNot = newValue!;
              });
            },
            items: <String>['yes', 'no']
                .map<DropdownMenuItem<String>>((String value) {
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
    );
  }
}
