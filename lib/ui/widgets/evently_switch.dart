import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EventlySwitch extends StatefulWidget {
  final bool value;

  const EventlySwitch({super.key, required this.value});

  @override
  State<EventlySwitch> createState() => _EventlySwitchState();
}

class _EventlySwitchState extends State<EventlySwitch> {
  late bool _value = widget.value;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
      activeThumbColor: AppColors.white,
      activeTrackColor: AppColors.mainColor,
      inactiveThumbColor: AppColors.white,
      inactiveTrackColor: AppColors.disable,
      trackOutlineColor: WidgetStatePropertyAll(AppColors.stroke),
    );
  }
}
