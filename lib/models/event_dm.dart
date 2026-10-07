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

List<EventDm> events = [
  EventDm(
    category: categories[1],
    title: "We’re going to play football tomorrow",
    description:
    "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend mohammed.",
    dateTime: DateTime.now(),
    isFavorite: true,
  ),
  EventDm(
    category: categories[2],
    title: "Reading book club",
    description:
    "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
    isFavorite: true,
  ),
  EventDm(
    category: categories[3],
    title: "This is a Birthday Party",
    description:
    "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
    isFavorite: true,
  ),
  EventDm(
    category: categories[4],
    title: "Meeting for Updating The Development Method",
    description:
    "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
  ),
  EventDm(
    category: categories[5],
    title: "Discover unique exhibitions and talents",
    description:
    "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
  ),
  EventDm(
    category: categories[1],
    title: "We’re going to play football",
    description:
    "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend.",
    dateTime: DateTime.now(),
    isFavorite: true,
  ),
  EventDm(
    category: categories[3],
    title: "This is a Birthday Party",
    description:
    "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
    isFavorite: true,
  ),
  EventDm(
    category: categories[5],
    title: "Discover unique exhibitions and talents",
    description:
    "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
  ),
  EventDm(
    category: categories[1],
    title: "We’re going to play football",
    description:
    "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend.",
    dateTime: DateTime.now(),
    isFavorite: true,
  ),
  EventDm(
    category: categories[3],
    title: "This is a Birthday Party",
    description:
    "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
    isFavorite: true,
  ),
];