import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:learnfirebase/adminScreen/description.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
    final PageController _pageController = PageController();

  int currentPage = 0;

    @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                   Padding(
                     padding: EdgeInsets.all(15.0),
                     child: Text(
                       "Find your favourite place to live",
                       style: TextStyle(
                           fontFamily: 'myFont',
                           fontSize: 17,
                           fontWeight: FontWeight.bold,
                           color: Colors.black87),
                     ),
                   ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .where('status', isEqualTo: 'approved')
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
                                                    color: Colors.black,
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 4),
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
                                                height: 12,
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
              ),
            ],
          )),
    );
  }


}
