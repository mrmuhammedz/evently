import 'package:evently/models/category_dm.dart';

class EventDm {
  CategoryDm category;
  String title;
  String description;
  DateTime dateTime;
  bool isFavorite;


  EventDm({
    required this.category,
    required this.title,
    required this.description,
    required this.dateTime,
    this.isFavorite = false,
  });
}