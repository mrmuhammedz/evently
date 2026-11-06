import 'package:evently/models/category_dm.dart';
import 'package:flutter/material.dart';
import 'category_tap.dart';

class EventlyTapBar extends StatefulWidget {
  final List<CategoryDm> categories;
  final Function(EventCategory? id) onTap;

  const EventlyTapBar({
    super.key,
    required this.categories,
    required this.onTap,
  });

  @override
  State<EventlyTapBar> createState() => _EventlyTapBarState();
}

class _EventlyTapBarState extends State<EventlyTapBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            widget.onTap(widget.categories[index].id);
          });
        },
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        labelPadding: EdgeInsets.only(right: 8),
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        tabAlignment: .start,
        isScrollable: true,
        tabs: widget.categories.map((category) {
          return CategoryTab(
            title: category.name,
            selectedIcon: category.iconPath,
            icon: category.selectedIconPath,
            isSelected: _currentIndex == widget.categories.indexOf(category),
          );
        }).toList(),
      ),
    );
  }
}
