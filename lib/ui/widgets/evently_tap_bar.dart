import 'package:evently/models/category_dm.dart';
import 'package:flutter/material.dart';
import 'category_tap.dart';

class EventlyTapBar extends StatefulWidget {
  final List<CategoryDm> categories;
  final Function(CategoryDm category) onTap;

  const EventlyTapBar({super.key, required this.categories, required this.onTap});

  @override
  State<EventlyTapBar> createState() => _EventlyTapBarState();
}

class _EventlyTapBarState extends State<EventlyTapBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        onTap: (index) {
        setState(() {
            currentIndex = index;
            widget.onTap(widget.categories[index]);
          });
        },
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        labelPadding: EdgeInsets.only(right: 8),
        indicator: const BoxDecoration(),
        dividerColor: Colors.transparent,
        tabAlignment: .start,
        isScrollable: true,
        tabs: widget.categories.map((category) {
          return CategoryTab(
            title: category.name,
            icon: category.iconPath,
            selectedIcon: category.selectedIconPath,
            isSelected: currentIndex == widget.categories.indexOf(category),
          );
        }).toList(),
      ),
    );
  }
}
