import 'package:flutter/material.dart';

class MyBar extends StatelessWidget {
  const MyBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pop(context);
              Navigator.pushNamed(context, '/ingredient');
              break;
            case 2:
              Navigator.pop(context);
              Navigator.pushNamed(context, '/food');
              break;
            default:
          }
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.kitchen, color: Colors.black),
            label: 'ktichen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.black),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
