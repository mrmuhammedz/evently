import 'dart:async';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_dm.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/event_service.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/category_image.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:evently/ui/widgets/evently_header.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_scaffold.dart';
import 'package:evently/ui/widgets/evently_tap_bar.dart';
import 'package:evently/ui/widgets/evently_text_form_field.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventScreenWidget extends StatefulWidget {
  final EventDm? event;

  const EventScreenWidget({super.key, this.event});

  @override
  State<EventScreenWidget> createState() => _EventScreenWidgetState();
}

class _EventScreenWidgetState extends State<EventScreenWidget> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final _now = DateTime.now();
  late DateTime _selectedDateTime;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  EventCategory? _selectedCategory = allCategories[1].id;
  String? _errorMessage;
  bool _isLoading = false;
  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;
  ThemeData get _theme => Theme.of(context);

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description;
      _selectedCategory = widget.event!.categoryId;
      _selectedDateTime = widget.event!.dateTime;

      _selectedDate = DateTime(
        widget.event!.dateTime.year,
        widget.event!.dateTime.month,
        widget.event!.dateTime.day,
      );
      _selectedTime = TimeOfDay.fromDateTime(widget.event!.dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return EventlyScaffold(
      child: Column(
        children: [
          const SizedBox(height: 16),
          screenHeader(),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CategoryImage(id: _selectedCategory!),
                  const SizedBox(height: 16),
                  tapBar(),
                  const SizedBox(height: 16),
                  addForm(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          eventSubmissionButton(),
          if (_errorMessage != null) ...[
            SizedBox(height: 8),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: AppStyles.regularTextStyle14.copyWith(
                color: AppColors.red,
              ),
            ),
          ],
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  EventlyHeader screenHeader() {
    return EventlyHeader(
      center: Text(
        widget.event == null
            ? _appLocalizations.addEvent
            : _appLocalizations.editEvent,
        style: AppStyles.mediumTextStyle18.copyWith(
          color: _theme.colorScheme.onSecondary,
        ),
      ),
      leading: ButtonWidget(
        onTap: () => Navigator.pop(context),
        child: SvgAsset(
          asset: Localizations.localeOf(context).languageCode == "en"
              ? AppIcons.arrowLeft
              : AppIcons.arrowRight,
          color: _theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  EventlyTapBar tapBar() {
    return EventlyTapBar(
      categories: allCategories.skip(1).toList(),
      currentCategory: _selectedCategory,
      onTap: (id) {
        setState(() => _selectedCategory = id);
      },
    );
  }

  Form addForm() {
    return Form(
      key: _key,
      child: Column(
        children: [
          titleField(),
          const SizedBox(height: 16),
          descriptionField(),
          const SizedBox(height: 16),
          dateRow(),
          const SizedBox(height: 16),
          timeRow(),
        ],
      ),
    );
  }

  Widget titleField() {
    return textFieldContainer(
      label: _appLocalizations.title,
      hintText: _appLocalizations.eventTitle,
      controller: _titleController,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return _appLocalizations.pleaseEnterEventTitle;
        }
        return null;
      },
    );
  }

  Widget descriptionField() {
    return textFieldContainer(
      label: _appLocalizations.description,
      hintText: _appLocalizations.eventDescription,
      lines: 7,
      controller: _descriptionController,
      textInputAction: TextInputAction.newline,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return _appLocalizations.pleaseEnterEventDescription;
        }
        return null;
      },
    );
  }

  Widget dateRow() {
    return eventDateTimeRow(
      icon: AppIcons.calendar,
      title: _appLocalizations.eventDate,
      value: _selectedDate != null
          ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
          : _appLocalizations.chooseDate,
      onTap: () async {
        final pickedDate = await showDatePicker(
          confirmText: _appLocalizations.add,
          context: context,
          initialDate: _selectedDate ?? _now,
          firstDate: _now,
          lastDate: _now.add(const Duration(days: 365)),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
            _selectedDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              _selectedTime?.hour ?? 0,
              _selectedTime?.minute ?? 0,
            );
          });
        }
      },
    );
  }

  Widget timeRow() {
    return eventDateTimeRow(
      icon: AppIcons.clock,
      title: _appLocalizations.eventTime,
      value: _selectedTime != null
          ? DateFormat(
              'hh:mm a',
              _appLocalizations.localeName,
            ).format(_selectedDateTime)
          : _appLocalizations.chooseTime,
      onTap: () async {
        final pickedTime = await showTimePicker(
          confirmText: _appLocalizations.add,
          context: context,
          initialTime: _selectedTime ?? TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            _selectedTime = pickedTime;
            _selectedDateTime = DateTime(
              _selectedDate?.year ?? _now.year,
              _selectedDate?.month ?? _now.month,
              _selectedDate?.day ?? _now.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          });
        }
      },
    );
  }

  Widget eventSubmissionButton() {
    return EventlyButton(
      onPresses: onSubmissionPress,
      child: _isLoading
          ? CircularProgressIndicator(color: AppColors.white)
          : Text(
              widget.event == null
                  ? _appLocalizations.addEvent
                  : _appLocalizations.updateEvent,
              style: AppStyles.mediumTextStyle20.copyWith(
                color: AppColors.white,
              ),
            ),
    );
  }

  Future<void> onSubmissionPress() async {
    if (_isLoading) return;
    if (!_key.currentState!.validate()) {
      return;
    }
    if (_selectedDate == null || _selectedTime == null) {
      setState(() => _errorMessage = _appLocalizations.pleaseSelectDateAndTime);
      return;
    }
    if (_selectedDateTime.isBefore(_now.add(const Duration(hours: 1)))) {
      setState(
        () => _errorMessage =
            _appLocalizations.pleaseSelectTimeAtLeastOneHourAhead,
      );
      return;
    }
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    try {
      widget.event == null
          ? await EventService()
                .addEvent(
                  userId: context.read<UserProvider>().user!.id,
                  title: _titleController.text.trim(),
                  description: _descriptionController.text.trim(),
                  categoryId: _selectedCategory!,
                  dateTime: _selectedDateTime,
                )
                .timeout(const Duration(seconds: 30))
          : await EventService()
                .updateEvent(
                  EventDm(
                    id: widget.event!.id,
                    userId: widget.event!.userId,
                    categoryId: _selectedCategory!,
                    title: _titleController.text.trim(),
                    description: _descriptionController.text.trim(),
                    dateTime: _selectedDateTime,
                  ),
                )
                .timeout(const Duration(seconds: 30));
      if (!mounted) return;
      Navigator.pop(context);
      if (widget.event != null) Navigator.pop(context);
    } on TimeoutException {
      setState(() => _errorMessage = _appLocalizations.timedOut);
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget textFieldContainer({
    required String label,
    TextInputAction? textInputAction,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int lines = 1,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 8,
    children: [
      Text(
        label,
        style: AppStyles.mediumTextStyle16.copyWith(
          color: _theme.colorScheme.onSecondary,
        ),
      ),
      EventlyTextFormField(
        validator: validator,
        textInputAction: textInputAction,
        hintText: hintText,
        minLines: lines,
        controller: controller,
      ),
    ],
  );

  Widget eventDateTimeRow({
    required String icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) => Row(
    children: [
      SvgAsset(asset: icon, color: _theme.primaryColor),
      const SizedBox(width: 8),
      Text(
        title,
        style: AppStyles.mediumTextStyle16.copyWith(
          color: _theme.colorScheme.onSecondary,
        ),
      ),
      const Spacer(),
      GestureDetector(
        onTap: onTap,
        child: Text(
          value,
          style: AppStyles.regularTextStyle14.copyWith(
            decoration: TextDecoration.underline,
            color: _theme.primaryColor,
            decorationColor: _theme.primaryColor,
          ),
        ),
      ),
    ],
  );
}
