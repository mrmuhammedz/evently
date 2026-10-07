import 'package:evently/models/event_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final List<EventDm> events;
  final int index;

  const EventCard({super.key, required this.events, required this.index});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height * 0.24,
          decoration: BoxDecoration(border: Border.all(color: AppColors.stroke)),
          child: Stack(
            children: [
              Image.asset(
                events[index].category.imagePath!,
                fit: BoxFit.fitWidth,
              ),
              Align(
                alignment: .topStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonWidget(
                    onTap: () {},
                    bgColor: AppColors.background,
                    horizontalPadding: 8,
                    verticalPadding: 8,
                    child: Text(
                      "${events[index].dateTime.day} October",
                      style: AppStyles.mainColor16semiBold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: .bottomStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonWidget(
                    onTap: () {},
                    bgColor: AppColors.background,
                    horizontalPadding: 8,
                    verticalPadding: 8,
                    icon: events[index].isFavorite ? AppIcons.filledHeart : AppIcons.heart,
                    child: Text(
                      events[index].title,
                      style: AppStyles.mainText14medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
