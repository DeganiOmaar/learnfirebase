import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learnfirebase/post/post_offers.dart';
import 'package:learnfirebase/userscreen.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController bedNumberController = TextEditingController();

  String? categories;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: formstate,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Let's describe your house",
                  style: TextStyle(
                      fontFamily: 'myFont',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(
                  height: 10,
                ),
                jobTextField(
                    controller: locationController,
                    title: 'Location',
                    validator: (location) {
                      return location!.isEmpty ? "Can't be Empty" : null;
                    },
                    keybordtype: TextInputType.text),
                const SizedBox(
                  height: 12,
                ),
                jobTextField(
                    controller: priceController,
                    title: 'Price',
                    validator: (price) {
                      return price!.isEmpty ? "Can't be Empty" : null;
                    },
                    keybordtype: TextInputType.number),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'myFont',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black45)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: DropdownButton<String>(
                            value: categories,
                            elevation: 8,
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 18),
                            onChanged: (newValue) {
                              setState(() {
                                categories = newValue!;
                              });
                            },
                            items: <String>['Family', 'Boys', 'Girls', 'Couple']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                jobTextField(
                    controller: descriptionController,
                    title: 'About it',
                    validator: (description) {
                      return description!.isEmpty ? "Can't be Empty" : null;
                    },
                    keybordtype: TextInputType.text),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Room Numbers ?",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontFamily: 'myFont',
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SvgPicture.asset(
                          "assets/icons/room.svg",
                          height: 35,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 70,
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        validator: (roomNumber) {
                          return roomNumber!.isEmpty ? "Check it" : null;
                        },
                        controller: roomNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black45,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black45,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Bed Numbers ?",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontFamily: 'myFont',
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SvgPicture.asset(
                          "assets/icons/bed2.svg",
                          height: 35,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 70,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        validator: (bedNumber) {
                          return bedNumber!.isEmpty ? "Check it" : null;
                        },
                        controller: bedNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black45,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black45,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black38,
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const UserScreen()));
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black87),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
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
                          if (formstate.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostOffers(
                                      location: locationController.text,
                                      price: priceController.text,
                                      categories: categories,
                                      description: descriptionController.text,
                                      roomNumber: roomNumberController.text,
                                      bedNumber: bedNumberController.text),
                                ));
                          }
                        },
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.indigo),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        child: const Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget jobTextField(
      {required TextEditingController controller,
      required String title,
      required String? Function(String?)? validator,
      required TextInputType keybordtype}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontFamily: 'myFont',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 150),
          child: TextFormField(
            keyboardType: keybordtype,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            controller: controller,
            cursorColor: Colors.black87,

            maxLines: null, // Set maxLines to null for auto-wrapping
            decoration: InputDecoration(
              // hintText: description,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
