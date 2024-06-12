import 'dart:math';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> items = [
    {"id": 1, "name": "ishan", "phoneNo": 9925100624},
    {"id": 2, "name": "hunal", "phoneNo": 9925100624},
    {"id": 3, "name": "harshil", "phoneNo": 9925100624},
    {"id": 4, "name": "krishna", "phoneNo": 9925100624},
    {"id": 5, "name": "sneh", "phoneNo": 9925100624},
    {"id": 6, "name": "parthiv", "phoneNo": 9925100624},
    {"id": 7, "name": "rachit", "phoneNo": 9925100624},
    {"id": 8, "name": "jeel", "phoneNo": 9925100624},
    {"id": 9, "name": "dev", "phoneNo": 9925100624},
    {"id": 10, "name": "het", "phoneNo": 9925100624},
    {"id": 11, "name": "ayush", "phoneNo": 9925100624},
  ];
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background color
      appBar: AppBar(
        backgroundColor: Colors.teal, // App bar color
        title: Text("Contacts",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Container background color
        ),
        height: MediaQuery.of(context).size.height / 1.3,
        margin: EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            String name = items[index]["name"];
            String firstLetter = name[0].toUpperCase();
            Color? circleColor = items[index]['circleColor'];

            if (circleColor == null) {
              // If color is not already generated, generate one and store it in the item
              final random = Random();
              final num = random.nextInt(colors.length);
              circleColor = colors[num];
              items[index]['circleColor'] = circleColor;
            }

            return Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Card(
                color: Colors.white,
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: circleColor,
                      child: Text(
                        firstLetter,
                        style: TextStyle(
                          color: Colors.white, // First letter color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      name,
                      style: TextStyle(
                        color: Colors.black, // Name text color
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      items[index]['phoneNo'].toString(),
                      style: TextStyle(
                        color: Colors.grey[600], // Subtitle text color
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
