import 'package:evently/ui/utils/app_assets.dart';

enum EventCategory { sport, bookClub, birthday, meeting, exhibition }

class CategoryDm {
  final EventCategory? id;
  final String name;
  final String? imagePath;
  final String? darkImagePath;
  final String iconPath;
  final String selectedIconPath;

  const CategoryDm({
    required this.id,
    required this.name,
    this.imagePath,
    this.darkImagePath,
    required this.iconPath,
    required this.selectedIconPath,
  });

  String? getImagePath(bool isDarkMode) {
    return isDarkMode ? darkImagePath : imagePath;
  }

  static CategoryDm getCategoryById(EventCategory id) =>
      allCategories.firstWhere((category) => category.id == id);
}

const List<CategoryDm> allCategories = [
  CategoryDm(
    id: null,
    name: "All",
    iconPath: AppIcons.filledGrid,
    selectedIconPath: AppIcons.grid,
  ),
  CategoryDm(
    id: EventCategory.sport,
    name: "Sport",
    imagePath: AppImages.sport,
    darkImagePath: AppImages.darkSport,
    iconPath: AppIcons.filledBike,
    selectedIconPath: AppIcons.bike,
  ),
  CategoryDm(
    id: EventCategory.bookClub,
    name: "Book Club",
    imagePath: AppImages.bookClub,
    darkImagePath: AppImages.darkBookClub,
    iconPath: AppIcons.filledBook,
    selectedIconPath: AppIcons.book,
  ),
  CategoryDm(
    id: EventCategory.birthday,
    name: "Birthday",
    imagePath: AppImages.birthday,
    darkImagePath: AppImages.darkBirthday,
    iconPath: AppIcons.filledBirthdayCake,
    selectedIconPath: AppIcons.birthdayCake,
  ),
  CategoryDm(
    id: EventCategory.meeting,
    name: "Meeting",
    imagePath: AppImages.meeting,
    darkImagePath: AppImages.darkMeeting,
    iconPath: AppIcons.filledHandshake,
    selectedIconPath: AppIcons.handshake,
  ),
  CategoryDm(
    id: EventCategory.exhibition,
    name: "Exhibition",
    imagePath: AppImages.exhibition,
    darkImagePath: AppImages.darkExhibition,
    iconPath: AppIcons.filledExhibition,
    selectedIconPath: AppIcons.exhibition,
  ),
];
