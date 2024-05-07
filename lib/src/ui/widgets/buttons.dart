import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scheduler/src/globals/theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  const AppButton({required this.label, required this.callback, super.key});

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: callback,
      child: Container(
        width: 150,
        height: 45,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: mainTheme.colorScheme.primary),
        child: Center(
          child: Text(label, style: mainTheme.textTheme.labelLarge?.copyWith(fontSize: 15, color: mainTheme.colorScheme.background)),
        ),
      ));
}

class ScheduleButton extends StatelessWidget {
  final String actionLabel;
  final String timeLabel;
  final VoidCallback callback;
  const ScheduleButton({required this.actionLabel, required this.timeLabel, required this.callback, super.key});

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: callback,
      child: Container(
        width: 400,
        height: 35,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: mainTheme.colorScheme.secondary),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(actionLabel, style: mainTheme.textTheme.labelLarge?.copyWith(fontSize: 15, color: mainTheme.colorScheme.background)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(timeLabel, style: mainTheme.textTheme.labelLarge?.copyWith(fontSize: 15, color: mainTheme.colorScheme.background)),
              ),
            ],
          ),
        ),
      ));
}

class AppointmentButton extends StatelessWidget {
  final String actionLabel;
  final String dateLabel;
  final String timeLabel;
  final VoidCallback callback;
  const AppointmentButton({required this.actionLabel, required this.dateLabel, required this.timeLabel, required this.callback, super.key});

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: callback,
      child: Container(
        width: 400,
        height: 35,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: mainTheme.colorScheme.secondary),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(actionLabel, style: mainTheme.textTheme.labelLarge?.copyWith(fontSize: 15, color: mainTheme.colorScheme.background)),
              ),
              Text(dateLabel, style: mainTheme.textTheme.labelLarge?.copyWith(fontSize: 15, color: mainTheme.colorScheme.background)),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(timeLabel, style: mainTheme.textTheme.labelLarge?.copyWith(fontSize: 15, color: mainTheme.colorScheme.background)),
              ),
            ],
          ),
        ),
      ));
}
