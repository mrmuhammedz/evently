import 'package:evently/ui/utils/app_assets.dart';

enum EventCategory { sport, bookClub, birthday, meeting, exhibition }

class CategoryDm {
  final EventCategory? id;
  final String name;
  final String? imagePath;
  final String iconPath;
  final String selectedIconPath;

  const CategoryDm({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.iconPath,
    required this.selectedIconPath,
  });

  static CategoryDm getCategoryById(EventCategory id) =>
      allCategories.firstWhere((category) => category.id == id);
}

const List<CategoryDm> allCategories = [
  CategoryDm(
    id: null,
    name: "All",
    imagePath: null,
    iconPath: AppIcons.filledGrid,
    selectedIconPath: AppIcons.grid,
  ),
  CategoryDm(
    id: EventCategory.sport,
    name: "Sport",
    imagePath: AppImages.sport,
    iconPath: AppIcons.filledBike,
    selectedIconPath: AppIcons.bike,
  ),
  CategoryDm(
    id: EventCategory.bookClub,
    name: "Book Club",
    imagePath: AppImages.bookClub,
    iconPath: AppIcons.filledBook,
    selectedIconPath: AppIcons.book,
  ),
  CategoryDm(
    id: EventCategory.birthday,
    name: "Birthday",
    imagePath: AppImages.birthday,
    iconPath: AppIcons.filledBirthdayCake,
    selectedIconPath: AppIcons.birthdayCake,
  ),
  CategoryDm(
    id: EventCategory.meeting,
    name: "Meeting",
    imagePath: AppImages.meeting,
    iconPath: AppIcons.filledHandshake,
    selectedIconPath: AppIcons.handshake,
  ),
  CategoryDm(
    id: EventCategory.exhibition,
    name: "Exhibition",
    imagePath: AppImages.exhibition,
    iconPath: AppIcons.filledExhibition,
    selectedIconPath: AppIcons.exhibition,
  ),
];
