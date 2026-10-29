import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:evently/ui/widgets/evently_header.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_scaffold.dart';
import 'package:evently/ui/widgets/evently_tap_bar.dart';
import 'package:evently/ui/widgets/evently_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  CategoryDm selectedCategory = categories[1];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return EventlyScaffold(
      child: Column(
        children: [
          const SizedBox(height: 16),
          EventlyHeader(
            center: Text(
              appLocalizations.addEvent,
              style: AppStyles.mainText18medium,
            ),
            leading: ButtonWidget(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                Localizations.localeOf(context).languageCode == "en"
                    ? AppIcons.arrowLeft
                    : AppIcons.arrowRight,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.stroke),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        selectedCategory.imagePath!,
                        fit: .fitWidth,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  EventlyTapBar(
                    categories: categories.skip(1).toList(),
                    onTap: (category) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  textFieldContainer(
                    label: appLocalizations.title,
                    hintText: appLocalizations.eventTitle,
                    controller: titleController,
                  ),
                  const SizedBox(height: 16),
                  textFieldContainer(
                    label: appLocalizations.description,
                    hintText: appLocalizations.eventDescription,
                    minLines: 7,
                    controller: descriptionController,
                  ),
                  const SizedBox(height: 16),
                  eventDateTimeRow(
                    icon: AppIcons.calendar,
                    title: appLocalizations.eventDate,
                    value: selectedDate != null
                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                        : appLocalizations.chooseDate,
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        confirmText: appLocalizations.add,
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  eventDateTimeRow(
                    icon: AppIcons.clock,
                    title: appLocalizations.eventTime,
                    value: selectedTime != null
                        ? "${selectedTime!.hour.toString().padLeft(2, "0")}:${selectedTime!.minute.toString().padLeft(2, "0")}"
                        : appLocalizations.chooseTime,
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        confirmText: appLocalizations.add,
                        context: context,
                        initialTime: selectedTime ?? TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          EventlyButton(
            child: Text(
              appLocalizations.addEvent,
              style: AppStyles.white20medium,
            ),
            onPresses: () {
              // TODO add event to firestore
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 7),
        ],
      ),
    );
  }

  Widget textFieldContainer({
    required String label,
    required String hintText,
    required TextEditingController controller,
    int minLines = 1,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 8,
    children: [
      Text(label, style: AppStyles.mainText16medium),
      EventlyTextField(
        hintText: hintText,
        minLines: minLines,
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
      SvgPicture.asset(icon),
      const SizedBox(width: 8),
      Text(title, style: AppStyles.mainText16medium),
      const Spacer(),
      GestureDetector(
        onTap: onTap,
        child: Text(
          value,
          style: AppStyles.mainColor14regular.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  );
}
