import 'package:evently/models/category_dm.dart';

class EventDm {
  String id;
  String userId;
  CategoryDm category;
  String title;
  String description;
  DateTime dateTime;

  EventDm({
    required this.id,
    required this.userId,
    required this.category,
    required this.title,
    required this.description,
    required this.dateTime,
  });
}

List<EventDm> events = [
  EventDm(
    category: categories[1],
    title: "We’re going to play football tomorrow",
    description:
        "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend mohammed.",
    dateTime: DateTime.now(),
    id: '',
    userId: '',
  ),
  EventDm(
    category: categories[2],
    title: "Reading book club",
    description:
        "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
    id: '',
    userId: '',
  ),
  EventDm(
    category: categories[3],
    title: "This is a Birthday Party",
    description:
        "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
    id: '',
    userId: '',
  ),
  EventDm(
    category: categories[4],
    title: "Meeting for Updating The Development Method",
    description:
        "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
    id: '',
    userId: '',
  ),
  EventDm(
    category: categories[5],
    title: "Discover unique exhibitions and talents",
    description:
        "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
    id: '',
    userId: '',
  ),
  EventDm(
    category: categories[1],
    title: "We’re going to play football",
    description: "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend.",
    dateTime: DateTime.now(),
    id: '',
    userId: '',
  ),
  EventDm(
    category: categories[3],
    title: "This is a Birthday Party",
    description:
        "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
    id: '',
    userId: '',
  ),
  EventDm(
    category: categories[5],
    title: "Discover unique exhibitions and talents",
    description:
        "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
    id: '',
    userId: '',
  ),
  EventDm(
    category: categories[1],
    title: "We’re going to play football",
    description: "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend.",
    dateTime: DateTime.now(),
    id: '',
    userId: '',
  ),
  EventDm(
    category: categories[3],
    title: "This is a Birthday Party",
    description:
        "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
    dateTime: DateTime.now(),
    id: '',
    userId: '',
  ),
];
