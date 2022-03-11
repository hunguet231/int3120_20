import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film Chill',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Film Chill'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

  class _MyHomePageState extends State<MyHomePage> {
    final films = [
      {
        'title': 'Tuổi 25, Tuổi 21',
        'cover': 'https://dongphymtv.com/public/files/flim/120x160/1644597035.jpg',
        'description': 'Twenty-Five Twenty-One (2021)',
        'rating': 5.0
      },
      {
        'title': 'Hẹn Hò Chốn Công Sở',
        'cover': 'https://dongphymtv.com/public/files/flim/120x160/1644498363.jpg',
        'description': 'A Business Proposal (2022)',
        'rating': 4.5
      },
      {
        'title': 'Dự Báo Tình Yêu Và Thời Tiết',
        'cover': 'https://dongphymtv.com/public/files/flim/120x160/1643858008.jpg',
        'description': 'Forecasting Love and Weather (2022)',
        'rating': 4.0
      },
      {
        'title': 'Công Tố Viên Quân Sự Do Bae Man',
        'cover': 'https://dongphymtv.com/public/files/flim/120x160/1644380968.jpg',
        'description': 'Military Prosecutor Doberman (2021)',
        'rating': 4.3
      },
      {
        'title': 'Những Quý Cô Tuổi 39',
        'cover': 'https://dongphymtv.com/public/files/flim/120x160/1639584825.jpg',
        'description': 'Thirty Nine (2022)',
        'rating': 3.5
      },
      {
        'title': 'Xin Chào Tay Súng Thần',
        'cover': 'https://dongphymtv.com/public/files/flim/120x160/1623690775_SnmlMsz.jpg',
        'description': 'Hello Sharpshooter (2021)',
        'rating': 3.0
      },
    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: films == null ? 1 : films.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: const Text('Đang thịnh hành',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      )),
                );
              }
              index -= 1;
              return ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(films[index]['cover'].toString()),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                title: Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Text(films[index]['title'].toString()),
                ),
                subtitle: GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 3.5),
                        child: Text(films[index]['description'].toString()),
                      ),
                      Row(
                          children: [
                            SmoothStarRating(
                                allowHalfRating: true,
                                onRated: (v) {
                                },
                                starCount: 5,
                                rating: double.parse(films[index]['rating'].toString()),
                                size: 20.0,
                                isReadOnly: true,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star_half,
                                defaultIconData: Icons.star_border,
                                color: Colors.orangeAccent,
                                borderColor: Colors.yellow,
                                spacing: 2.0
                            )
                          ],
                      )
                    ],
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(films[index]['title'].toString()),
                            content: Text(films[index]['description'].toString()),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.maybePop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
              );
            },
          ),
        ),
      );
    }
  }