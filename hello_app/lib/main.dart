import 'dart:ui';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp(
    items: fetchItems(),
  ));
}

List<Item> parseItems(http.Response response) {
  final parsed =
  json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();

  return parsed.map<Item>((json) => Item.fromMap(json)).toList();
}

Future<List<Item>> fetchItems() async {
  final response =
  await http.get(Uri.parse('http://192.168.1.2:8000/data.json'));

  if (response.statusCode == 200) {
    return parseItems(response);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.items}) : super(key: key);

  final Future<List<Item>> items;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Animation<double>? animation;

  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller!);
    controller!.forward();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller!.forward();
    return MaterialApp(
      title: 'Film Chill',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Film Chill', animation: animation),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.animation})
      : super(key: key);

  final String title;

  final Animation<double>? animation;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final films = [
    {
      'title': 'Tuổi 25, Tuổi 21',
      'cover':
          'https://dongphymtv.com/public/files/flim/120x160/1644597035.jpg',
      'description': 'Twenty-Five Twenty-One (2021)',
      'rating': 5.0
    },
    {
      'title': 'Hẹn Hò Chốn Công Sở',
      'cover':
          'https://dongphymtv.com/public/files/flim/120x160/1644498363.jpg',
      'description': 'A Business Proposal (2022)',
      'rating': 4.5
    },
    {
      'title': 'Dự Báo Tình Yêu Và Thời Tiết',
      'cover':
          'https://dongphymtv.com/public/files/flim/120x160/1643858008.jpg',
      'description': 'Forecasting Love and Weather (2022)',
      'rating': 4.0
    },
    {
      'title': 'Công Tố Viên Quân Sự Do Bae Man',
      'cover':
          'https://dongphymtv.com/public/files/flim/120x160/1644380968.jpg',
      'description': 'Military Prosecutor Doberman (2021)',
      'rating': 4.3
    },
    {
      'title': 'Những Quý Cô Tuổi 39',
      'cover':
          'https://dongphymtv.com/public/files/flim/120x160/1639584825.jpg',
      'description': 'Thirty Nine (2022)',
      'rating': 3.5
    },
    {
      'title': 'Xin Chào Tay Súng Thần',
      'cover':
          'https://dongphymtv.com/public/files/flim/120x160/1623690775_SnmlMsz.jpg',
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
      body: FadeTransition(
        opacity: widget.animation!,
        child: Container(
          color: Colors.blueGrey.shade900,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 15.0),
                  child: const Text('Đang thịnh hành',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: Colors.white)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: films.length,
                  itemBuilder: (context, index) {
                    final itemData = films[index];
                    final item = Item(
                        itemData['title'].toString(),
                        itemData['description'].toString(),
                        itemData['cover'].toString(),
                        itemData['rating'].toString());

                    return ItemRow(item: item);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemPage extends StatelessWidget {
  const ItemPage({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: ScopedModel(
        model: item,
        child: Container(
          color: Colors.blueGrey.shade900,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    child: Image.network(item.cover),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  item.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 3.5),
                    child: Text(
                      item.description,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Rating(item: item)],
                  ),
                  ElevatedButton(
                    child: const Text('Xem phim'),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: item,
        child: Column(
          children: [
            InkWell(
                splashColor: Colors.grey.shade400,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemPage(item: item)),
                  );
                },
                child: ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(item.cover), fit: BoxFit.cover),
                    ),
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      item.title,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 3.5),
                        child: Text(
                          item.description,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white70),
                        ),
                      ),
                      Rating(item: item)
                    ],
                  ),
                ))
          ],
        ));
  }
}

class Rating extends StatelessWidget {
  const Rating({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmoothStarRating(
            allowHalfRating: true,
            onRated: (v) {},
            starCount: 5,
            rating: double.parse(item.rating),
            size: 20.0,
            isReadOnly: true,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            color: Colors.orangeAccent,
            borderColor: Colors.yellow,
            spacing: 2.0)
      ],
    );
  }
}

class Item extends Model {
  final String title;
  final String description;
  final String cover;
  final String rating;

  Item(this.title, this.description, this.cover, this.rating);

  factory Item.fromMap(Map<String, dynamic> json) {
    return Item(
        json['title'], json['description'], json['cover'], json['rating']);
  }
}
