import 'package:flutter/material.dart';
import './tabs/HomePage.dart';
import './tabs/LivePage.dart';
import './tabs/Mine.dart';
import './tabs/MyTickets.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    //
    HomePage(),
    LivePage(),
    MyTickets(),
    Mine()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Test")),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: (Color.fromRGBO(241, 7, 75, 1)),
          backgroundColor: Color.fromRGBO(8, 11, 32, 1),
          unselectedItemColor: (Color.fromARGB(255, 83, 99, 131)),
          selectedFontSize: 11,
          unselectedFontSize: 11,
          showUnselectedLabels: true,
          iconSize: 30,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              //重新build
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "首页",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.visibility),
              label: "现场",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: "票夹",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "我的",
            ),
          ]),
    );
  }
}
