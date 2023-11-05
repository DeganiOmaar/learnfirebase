// ignore_for_file: deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnfirebase/adminScreen/description.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Map imagesData = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "All Pending Posts",
                      style: TextStyle(fontSize: 21, fontFamily: 'myFont'),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .where('status', isEqualTo: 'pending')
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
                              color: Colors.white,
                              secondRingColor: Colors.indigo,
                              thirdRingColor: Colors.pink.shade400),
                        );
                      }

                      return Stack(
                        children: [
                          ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data2 =
                                  document.data()! as Map<String, dynamic>;
                              if (snapshot.hasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('posts')
                                          .doc(data2['docId'])
                                          .collection('images')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              'Something went wrong');
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .discreteCircle(
                                                    size: 32,
                                                    color: Colors.white,
                                                    secondRingColor:
                                                        Colors.indigo,
                                                    thirdRingColor:
                                                        Colors.pink.shade400),
                                          );
                                        }

                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            child: Row(
                                              children: snapshot.data!.docs.map(
                                                  (DocumentSnapshot document) {
                                                Map<String, dynamic> data =
                                                    document.data()!
                                                        as Map<String, dynamic>;
                                                if (snapshot.hasData) {
                                                  List<Map<String, dynamic>>
                                                      dataList = snapshot
                                                          .data!.docs
                                                          .map((DocumentSnapshot
                                                              document) {
                                                    Map<String, dynamic> data =
                                                        document.data() as Map<
                                                            String, dynamic>;
                                                    return data;
                                                  }).toList();
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Description(
                                                                        postDetails:
                                                                            data2,
                                                                        images:
                                                                            dataList,
                                                                      )));
                                                    },
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 15),
                                                        height: MediaQuery
                                                                    .of(context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.86,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          14)),
                                                          child: Image.network(
                                                            data['url'],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    data2['location'],
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                'hosted by ${data2['hosted_name']}',
                                                style: const TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                DateFormat('yMMMd').format(
                                                    data2['datePublished']
                                                        .toDate()),
                                                style: const TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    data2['price'],
                                                    style: const TextStyle(
                                                        fontFamily: 'myFont',
                                                        color: Colors.black87,
                                                        fontSize: 17),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  const Text(
                                                    'Month',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            }).toList(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
