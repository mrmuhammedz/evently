import 'package:evently/models/category_dm.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_tap_bar.dart';
import 'package:evently/ui/widgets/events_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
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
    List<EventDm> events = [
      EventDm(
        category: categories[1],
        title: "We’re going to play football",
        description:
            "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend.",
        dateTime: DateTime.now(),
        isFavorite: true,
      ),
      EventDm(
        category: categories[2],
        title: "Reading book club",
        description:
            "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit",
        dateTime: DateTime.now(),
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
    var filteredEvents = selectedCategoryIndex == 0
        ? events
        : events
              .where(
                (event) => event.category == categories[selectedCategoryIndex],
              )
              .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(height: 24),
          buildHeader(),
          SizedBox(height: 24),
          EventlyTapBar(
            categories: categories,
            onTap: (category) {
              setState(() {
                selectedCategoryIndex = categories.indexOf(category);
              });
            },
          ),
          SizedBox(height: 24),
          EventsList(events: filteredEvents),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text("Welcome Back ✨", style: AppStyles.secText14regular),
              Text(
                "Mr.Muhammadz",
                style: AppStyles.mainText20medium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            SvgPicture.asset(AppIcons.sun),
            ButtonWidget(
              onTap: () {},
              horizontalPadding: 8,
              verticalPadding: 5.5,
              bgColor: AppColors.mainColor,
              child: Text("EN", style: AppStyles.white14semiBold),
            ),
          ],
        ),
      ],
    );
  }
}
