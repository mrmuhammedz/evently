import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/event_service.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/category_image.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  final EventDm event;
  final String heroTag;

  const EventCard({super.key, required this.event, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final isFavorite = context.select<UserProvider, bool>(
      (provider) => provider.isFavorite(event.id),
    );
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    bool isEventEnded = DateTime.now().isAfter(event.dateTime);

    return GestureDetector(
      onTap: () {
        // Handle event card tap
        Navigator.push(
          context,
          AppRoutes.eventDetailsRoute(event: event, heroTag: heroTag),
        );
      },
      child: Stack(
        children: [
          Hero(
            tag: heroTag,
            child: CategoryImage(id: event.categoryId),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ButtonWidget(
                    bgColor: theme.scaffoldBackgroundColor,
                    horizontalPadding: 8,
                    verticalPadding: 8,
                    child: Text(
                      "${DateFormat('d MMM', appLocalizations.localeName).format(event.dateTime)}${isEventEnded ? "\n ${appLocalizations.eventEnded}" : ''}",
                      style: isEventEnded
                          ? AppStyles.semiBoldTextStyle16.copyWith(
                              color: AppColors.darkRed,
                            )
                          : AppStyles.semiBoldTextStyle16.copyWith(
                              color: theme.primaryColor,
                            ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  ButtonWidget(
                    bgColor: theme.scaffoldBackgroundColor,
                    horizontalPadding: 8,
                    verticalPadding: 8,
                    icon: GestureDetector(
                      onTap: () async {
                        userProvider.setFavorite(event.id, isFavorite);

                        try {
                          await EventService().updateFavorite(
                            eventId: event.id,
                            userId: userProvider.user!.id,
                            isFavorite: isFavorite,
                          );
                        } catch (_) {
                          userProvider.setFavorite(event.id, !isFavorite);
                        }
                      },
                      child: SvgAsset(
                        asset: isFavorite
                            ? AppIcons.filledHeart
                            : AppIcons.heart,
                        color: theme.primaryColor,
                      ),
                    ),
                    child: Text(
                      event.title,
                      style: AppStyles.mediumTextStyle14.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
