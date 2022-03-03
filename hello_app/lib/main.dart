import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film Chill',
      theme: ThemeData(
        primarySwatch: Colors.green,
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
      },
      {
        'title': 'Hẹn Hò Chốn Công Sở',
        'cover': 'https://dongphymtv.com/public/files/flim/120x160/1644498363.jpg',
        'description': 'A Business Proposal (2022)',
      },
      {
        'title': 'Dự Báo Tình Yêu Và Thời Tiết',
        'cover': 'https://dongphymtv.com/public/files/flim/120x160/1643858008.jpg',
        'description': 'Forecasting Love and Weather (2022)',
      },
      {
        'title': 'Công Tố Viên Quân Sự Do Bae Man',
        'cover': 'https://dongphymtv.com/public/files/flim/120x160/1644380968.jpg',
        'description': 'Military Prosecutor Doberman (2021)',
      },
      {
        'title': 'Những Quý Cô Tuổi 39',
        'cover': 'https://dongphymtv.com/public/files/flim/120x160/1639584825.jpg',
        'description': 'Thirty Nine (2022)',
      },
      {
        'title': 'Xin Chào Tay Súng Thần',
        'cover': 'https://dongphymtv.com/public/files/flim/120x160/1623690775_SnmlMsz.jpg',
        'description': 'Hello Sharpshooter (2021)',
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
            itemCount: films.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(films[index]['cover']!),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                title: Text(films[index]['title']!),
                subtitle: Text(films[index]['description']!),
              );
            },
          ),
        ),
      );
    }
  }