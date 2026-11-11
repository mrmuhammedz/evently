import 'package:evently/models/category_dm.dart';

class EventDm {
  String id;
  String userId;
  EventCategory categoryId;
  String title;
  String description;
  DateTime dateTime;

  EventDm({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.dateTime,
  });

  EventDm.fromJson(Map<String, dynamic> map)
    : id = map["id"],
      userId = map["userId"],
      categoryId = EventCategory.values.firstWhere(
        (category) => category.name == map["categoryId"],
      ),
      title = map["title"],
      description = map["description"],
      dateTime = map["dateTime"].toDate();

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "categoryId": categoryId.name,
      "title": title,
      "description": description,
      "dateTime": dateTime,
    };
  }
}
