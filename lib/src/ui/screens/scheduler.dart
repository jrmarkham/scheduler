import 'package:date_time_picker_selector/date_time_picker_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/src/data/blocs/date_selector/date_selector_cubit.dart';

import '../../data/blocs/navigation/navigation_cubit.dart';
import '../../data/blocs/shared_preferences/shared_preferences_cubit.dart';
import '../../data/models/timeslot_data.dart';
import '../../globals/consts.dart';
import '../../utils/string_utils.dart' as string_utils;
import '../../globals/navigation_enum.dart';
import '../scaffold/core_scaffold.dart';
import '../widgets/buttons.dart';

class Scheduler extends StatelessWidget {
  const Scheduler({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationCubit navigationCubit = BlocProvider.of<NavigationCubit>(context);
    SharedPreferencesCubit sharedPreferencesCubit = BlocProvider.of<SharedPreferencesCubit>(context);

    DateSelectorCubit dateSelectorCubit = DateSelectorCubit();

    //set dates to next day and week ahead
    final DateTime firstDate = DateTime.now().add(Duration(days: 1));

    final DateTime lastDate = DateTime.now().add(Duration(days: 8));
    void goToHomeScreen() => navigationCubit.navigate(NavigationEnum.home);
    void goToProviderScreen() => navigationCubit.navigate(NavigationEnum.provider);
    // date + timestart + int//
    void addTimeslotCallback({required DateTime dateTime, required int startTime}) =>
        sharedPreferencesCubit.addTimeslot(dateTime: dateTime, startTime: startTime);

    void removeTimeslotCallback(String tsID) => sharedPreferencesCubit.removeTimeslot(tsID);
    void cancelAppointCallback(String tsID) => sharedPreferencesCubit.cancelBooking(tsID);

    return CoreScaffold(
      BlocBuilder<SharedPreferencesCubit, SharedPreferencesState>(
        bloc: sharedPreferencesCubit,
        builder: (BuildContext context, SharedPreferencesState state) {
          final List<TimeslotData> appointments = sharedPreferencesCubit.getBookedTimeSlots();

          return BlocBuilder<DateSelectorCubit, DateTime?>(
              bloc: dateSelectorCubit,
              builder: (BuildContext context, DateTime? dateState) {
                void selectDate(String? val) => val != null ? dateSelectorCubit.selectDate(DateTime.parse(val)) : () => debugPrint('error');

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppButton(
                          label: 'Home',
                          callback: goToHomeScreen,
                        ),
                        AppButton(
                          label: 'Provider',
                          callback: goToProviderScreen,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (appointments.isNotEmpty) ...[
                      const Text('Appointments'),
                      Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: appointments.length,
                            itemBuilder: (
                              BuildContext context,
                              int idx,
                            ) {
                              final TimeslotData tsd = appointments[idx];

                              void cancelCallback() => cancelAppointCallback(tsd.id);
                              return AppointmentButton(
                                  actionLabel: 'Cancel Appointment',
                                  dateLabel: string_utils.getDateDisplay(tsd.date),
                                  timeLabel: timeslotsDisplay[tsd.startTime],
                                  callback: cancelCallback);
                            }),
                      ),
                    ],
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Select Date'),
                    DateTimePicker(
                      type: DateTimePickerType.date,
                      initialValue: firstDate.toString(),
                      firstDate: firstDate,
                      lastDate: lastDate,
                      onChanged: selectDate,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (dateState != null)
                      Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: timeslotsDisplay.length,
                            itemBuilder: (
                              BuildContext context,
                              int idx,
                            ) {
                              // get timeslot status data already exists //
                              final TimeslotStatusData statusData = sharedPreferencesCubit.getTimeSlotStatus(datetime: dateState, startTime: idx);

                              void callback() => statusData.status == TimeslotStatus.free
                                  ? addTimeslotCallback(dateTime: dateState, startTime: idx)
                                  : statusData.status == TimeslotStatus.booked
                                      ? cancelAppointCallback(statusData.id)
                                      : removeTimeslotCallback(statusData.id);

                              return ScheduleButton(
                                  actionLabel: statusData.status.getButtonProviderText(), timeLabel: timeslotsDisplay[idx], callback: callback);
                            }),
                      )
                  ],
                );
              });
        },
      ),
    );
  }
}
