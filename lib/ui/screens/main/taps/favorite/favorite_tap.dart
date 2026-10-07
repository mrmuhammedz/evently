import 'package:evently/models/event_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/widgets/evently_text_field.dart';
import 'package:evently/ui/widgets/events_list.dart';
import 'package:flutter/material.dart';

class FavoriteTap extends StatefulWidget {
  const FavoriteTap({super.key});

  @override
  State<FavoriteTap> createState() => _FavoriteTapState();
}

class _FavoriteTapState extends State<FavoriteTap> {
  String? searchText;

  @override
  Widget build(BuildContext context) {
    searchText = searchText?.trim().toLowerCase();
    var filteredEvents = searchText == null ? events : events.where((event) =>
        event.title.toLowerCase().contains(searchText!) || event.description.toLowerCase().contains(searchText!)).toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
          children: [
            SizedBox(height: 16,),
            EventlyTextField(hintText: "Search for event",
              suffixIcon: AppIcons.search,
              onChanged: (text) {
                setState(() {
                  searchText = text;
                });
              },),
            SizedBox(height: 16,),
            EventsList(
              events: filteredEvents.where((event) => event.isFavorite).toList(),)
          ]
      ),
    );
  }
}
