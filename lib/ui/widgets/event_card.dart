import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/models/category_dm.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/event_service.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  final EventDm event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final isFavorite = userProvider.isFavorite(event.id);
    final appLocalizations = AppLocalizations.of(context)!;
    bool isEventEnded = DateTime.now().isAfter(event.dateTime);

    return GestureDetector(
      onTap: () {
        // Handle event card tap
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                CategoryDm.getCategoryById(event.categoryId).imagePath!,
                fit: BoxFit.fill,
                height: double.infinity,
              ),
            ),
            Align(
              alignment: .topStart,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonWidget(
                  bgColor: AppColors.background,
                  horizontalPadding: 8,
                  verticalPadding: 8,
                  child: Text(
                    "${DateFormat('d MMM', appLocalizations.localeName).format(event.dateTime)}${isEventEnded ? "\n ${appLocalizations.eventEnded}" : ''}",
                    style: isEventEnded ? AppStyles.darkred16semiBold : AppStyles.mainColor16semiBold,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
            Align(
              alignment: .bottomStart,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonWidget(
                  bgColor: AppColors.background,
                  horizontalPadding: 8,
                  verticalPadding: 8,
                  icon: GestureDetector(
                    onTap: () {
                      context.read<UserProvider>().updateFavorites(event.id);
                      EventService().addEventtoFavorites(event.id, userProvider.user!);
                    },
                    child: SvgPicture.asset(
                      isFavorite ? AppIcons.filledHeart : AppIcons.heart,
                    ),
                  ),
                  child: Text(event.title, style: AppStyles.mainText14medium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
