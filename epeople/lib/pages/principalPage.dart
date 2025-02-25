import 'package:epeople/pages/test.dart';
import 'package:epeople/pages/sendData.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Principalpage extends StatefulWidget {
  const Principalpage({super.key});

  @override
  State<Principalpage> createState() => _PrincipalpageState();
}

class _PrincipalpageState extends State<Principalpage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    const Center(child: Text('Home Page')),
    const Center(child: Text('Search Page')),
    const Center(child: Text('Add Page')),
    SendData(),
    DataPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text.rich(
        TextSpan(
            children: [
            TextSpan(
            text: 'e',
            style: TextStyle(color: Colors.orange, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            TextSpan(
            text: 'People',
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            ],
          ),
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
            Shadow(
              blurRadius: 10.0,
              color: Colors.black,
              offset: Offset(2.0, 2.0),
            ),
            ],
          ),
        ),
      actions: [
        IconButton(
        icon: const Icon(FontAwesomeIcons.bell),
          onPressed: () {},
        ),
      ],
      ),
      body: _pages[_selectedIndex],
      // le menu du as de l'application
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
          ),
          boxShadow: [
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 0,
          blurRadius: 10,
        ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.comments),
            label: 'chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.magnifyingGlass, size: 20.0),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size: 30.0),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.heart),
            label: 'Likes',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.person),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}