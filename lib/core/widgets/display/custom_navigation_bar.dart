import 'package:flutter/material.dart';

class Destination {
  const Destination(this.index, this.title, this.icon, this.color);

  final int index;
  final String title;
  final IconData icon;
  final MaterialColor color;
}

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({super.key});

  final List<ValueChanged<int>> onIndexChanged = <ValueChanged<int>>[];

  @override
  State<CustomBottomNavigationBar> createState() => CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;
  bool shouldShowNavigationBar = false;
  final List<Destination> allDestinations = <Destination>[];

  void showNavigationBar() {
    setState(() {
      shouldShowNavigationBar = true;
    });
  }

  void hideNavigationBar() {
    setState(() {
      shouldShowNavigationBar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return shouldShowNavigationBar && allDestinations.length >= 2
        ? BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (int index) {
        setState(() {
          selectedIndex = index;
        });
        // notify listeners
        for (final ValueChanged<int> callback in widget.onIndexChanged) {
          callback(index);
        }
      },
      items: allDestinations.map<BottomNavigationBarItem>(
            (Destination destination) {
          return BottomNavigationBarItem(
            icon: Icon(destination.icon, color: destination.color),
            label: destination.title,
          );
        },
      ).toList(),
    )
        : const SizedBox.shrink();
  }

  void addDestination(Destination destination) {
    setState(() {
      allDestinations.add(destination);
    });
  }

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}