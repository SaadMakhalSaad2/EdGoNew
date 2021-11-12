import 'package:flutter/material.dart';
import 'package:flutter_app/resources/resources.dart';

class CustomTapBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomTapBar(
      {key,
      required this.icons,
      required this.selectedIndex,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: onTap,
      indicatorPadding: EdgeInsets.zero,
      indicator: const BoxDecoration(
          border:
              Border(top: BorderSide(color: Palette.primaryColor, width: 3.0))),
      tabs: icons
          .asMap()
          .map((index, e) => MapEntry(
              index,
              Tab(
                icon: Icon(
                  e,
                  color: selectedIndex == index
                      ? Palette.primaryColor
                      : Palette.grey,
                  size: 30.0,
                ),
              )))
          .values
          .toList(),
    );
  }
}
