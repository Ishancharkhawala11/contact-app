import 'package:flutter/material.dart';
import 'package:practise/Pages/Favourite.dart';
import 'package:practise/Pages/Home.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTab = 0;
  late List<Widget> pages;
  late Home home;
  late Favourite fav;

  @override
  void initState() {
    home = Home();
    fav = Favourite();
    pages = [home, fav];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTab],
      bottomNavigationBar: SizedBox(
        height: 65,
        child: BottomNavigationBar(

          currentIndex: currentTab,
          onTap: (int index) {
            setState(() {
              currentTab = index;
            });
          },

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail_rounded,color: Colors.black,),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star,color: Colors.black),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
