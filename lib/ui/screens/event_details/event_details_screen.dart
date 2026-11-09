import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/event_service.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/category_image.dart';
import 'package:evently/ui/widgets/evently_dialog.dart';
import 'package:evently/ui/widgets/evently_header.dart';
import 'package:evently/ui/widgets/evently_scaffold.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventDm event;
  final String heroTag;
  const EventDetailsScreen({
    super.key,
    required this.event,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return EventlyScaffold(
      child: Column(
        children: [
          SizedBox(height: 16),
          screenHeader(context, appLocalizations, theme),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: heroTag,
                    child: CategoryImage(id: event.categoryId),
                  ),
                  SizedBox(height: 16),
                  Text(
                    event.title,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: AppStyles.mediumTextStyle18.copyWith(
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 16),
                  date(theme, appLocalizations),
                  SizedBox(height: 16),
                  description(theme, appLocalizations),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  EventlyHeader screenHeader(
    BuildContext context,
    AppLocalizations appLocalizations,
    ThemeData theme,
  ) {
    final user = context.watch<UserProvider>().user;

    return EventlyHeader(
      center: Text(
        appLocalizations.eventDetails,
        style: AppStyles.mediumTextStyle18.copyWith(
          color: theme.colorScheme.onSecondary,
        ),
      ),
      leading: ButtonWidget(
        onTap: () => Navigator.pop(context),
        child: SvgAsset(
          asset: Localizations.localeOf(context).languageCode == "en"
              ? AppIcons.arrowLeft
              : AppIcons.arrowRight,
          color: theme.colorScheme.onSurface,
        ),
      ),
      actions: [
        if (user!.id == event.userId) ...[
          ButtonWidget(
            child: SvgAsset(
              asset: AppIcons.edit,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(width: 8),
          ButtonWidget(
            child: SvgAsset(asset: AppIcons.trash),
            onTap: () =>
                deleteDialog(context, appLocalizations: appLocalizations),
          ),
        ],
      ],
    );
  }

  Future<void> deleteDialog(
    BuildContext context, {
    required AppLocalizations appLocalizations,
  }) async {
    final confirm = await eventlyShowDialog(
      context,
      title: appLocalizations.deleteEvent,
      content: appLocalizations.deleteConfirmation,
      cancel: appLocalizations.cancel,
      confirm: appLocalizations.delete,
    );

    if (confirm == true) {
      await EventService().deleteEvent(event.id);
      if (context.mounted) {
        context.read<UserProvider>().removeFavorite(event.id);
        Navigator.pop(context);
      }
    }
  }

  Container date(ThemeData theme, AppLocalizations appLocalizations) {
    return container(
      theme: theme,
      child: Row(
        children: [
          ButtonWidget(
            bgColor: theme.colorScheme.secondary,
            horizontalPadding: 10,
            verticalPadding: 10,
            child: SvgAsset(
              asset: AppIcons.calendar,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(width: 16),
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat(
                  'd MMMM',
                  appLocalizations.localeName,
                ).format(event.dateTime),
                style: AppStyles.mediumTextStyle16.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              Text(
                DateFormat(
                  'hh:mm a',
                  appLocalizations.localeName,
                ).format(event.dateTime),
                style: AppStyles.mediumTextStyle16.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column description(ThemeData theme, AppLocalizations appLocalizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          appLocalizations.description,
          style: AppStyles.mediumTextStyle16.copyWith(
            color: theme.colorScheme.onSecondary,
          ),
        ),
        container(
          theme: theme,
          child: Text(
            event.description,
            softWrap: true,
            textAlign: TextAlign.start,
            style: AppStyles.regularTextStyle14H.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Container container({required Widget child, required ThemeData theme}) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: child,
    );
  }
}
