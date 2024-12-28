import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Destination extends Equatable {
  const Destination(this.index, this.title, this.icon, this.color);

  final int index;
  final String title;
  final IconData icon;
  final MaterialColor color;

  @override
  List<Object?> get props => [index];
}

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;
  final List<Destination> allDestinations = <Destination>[];
  final List<ValueChanged<int>> onIndexChanged = <ValueChanged<int>>[];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return allDestinations.length >= 2
        ? BottomNavigationBar(
            selectedItemColor: colorScheme.primary,
            currentIndex: selectedIndex,
            onTap: (int index) {
              if (index == selectedIndex) {
                return;
              }

              setState(() {
                selectedIndex = index;
              });
              // notify listeners
              for (final ValueChanged<int> callback in onIndexChanged) {
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
