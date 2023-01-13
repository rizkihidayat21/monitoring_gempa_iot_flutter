import 'package:earthquake_detection_app/pages/beranda_screen.dart';
import 'package:earthquake_detection_app/pages/panduan_screen.dart';
import 'package:earthquake_detection_app/pages/riwayat_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _bottomNavCurrentIndex = 0;
  final List<Widget> _container = [
    BerandaScreen(),
    RiwayatScreen(),
    PanduanScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[_bottomNavCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        unselectedItemColor: Colors.yellow,
        backgroundColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _bottomNavCurrentIndex = index;
          });
        },
        currentIndex: _bottomNavCurrentIndex,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.home,
              color: Colors.yellow,
            ),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.assignment,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.assignment,
              color: Colors.yellow,
            ),
            label: "Riwayat",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.info,
              color: Colors.yellow,
            ),
            label: "Panduan",
          ),
        ],
      ),
    );
  }
}
