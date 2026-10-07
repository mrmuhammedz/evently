import 'package:evently/ui/utils/app_assets.dart';

class CategoryDm {
  String name;
  String? imagePath;
  String iconPath;
  String selectedIconPath;

  CategoryDm({
    required this.name,
    this.imagePath,
    required this.iconPath,
    required this.selectedIconPath,
  });
}

List<CategoryDm> categories = [
  CategoryDm(
    name: "All",
    iconPath: AppIcons.filledGrid,
    selectedIconPath: AppIcons.grid,
  ),
  CategoryDm(
    name: "Sport",
    imagePath: AppImages.sport,
    iconPath: AppIcons.filledBike,
    selectedIconPath: AppIcons.bike,
  ),
  CategoryDm(
    name: "Book Club",
    imagePath: AppImages.bookClub,
    iconPath: AppIcons.filledBook,
    selectedIconPath: AppIcons.book,
  ),
  CategoryDm(
    name: "Birthday",
    imagePath: AppImages.birthday,
    iconPath: AppIcons.filledBirthdayCake,
    selectedIconPath: AppIcons.birthdayCake,
  ),
  CategoryDm(
    name: "Meeting",
    imagePath: AppImages.meeting,
    iconPath: AppIcons.filledHandshake,
    selectedIconPath: AppIcons.handshake,
  ),
  CategoryDm(
    name: "Exhibition",
    imagePath: AppImages.exhibition,
    iconPath: AppIcons.filledExhibition,
    selectedIconPath: AppIcons.exhibition,
  ),
];