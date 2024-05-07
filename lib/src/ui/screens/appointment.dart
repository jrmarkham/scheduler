import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/src/data/blocs/shared_preferences/shared_preferences_cubit.dart';
import 'package:scheduler/src/data/models/timeslot_data.dart';

import '../../data/blocs/navigation/navigation_cubit.dart';
import '../../globals/consts.dart';
import '../../globals/navigation_enum.dart';
import '../../utils/string_utils.dart' as string_utils;
import '../scaffold/core_scaffold.dart';
import '../widgets/buttons.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationCubit navigationCubit = BlocProvider.of<NavigationCubit>(context);
    SharedPreferencesCubit sharedPreferencesCubit = BlocProvider.of<SharedPreferencesCubit>(context);

    void goToHomeScreen() => navigationCubit.navigate(NavigationEnum.home);
    void goToClientScreen() => navigationCubit.navigate(NavigationEnum.client);

    void bookAppointment(String tsID) => sharedPreferencesCubit.bookTimeslot(tsID);
    void cancelAppointCallback(String tsID) => sharedPreferencesCubit.cancelBooking(tsID);

    return BlocBuilder<SharedPreferencesCubit, SharedPreferencesState>(
      builder: (context, state) {
        return CoreScaffold(
          Column(
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
                    label: 'Client',
                    callback: goToClientScreen,
                  ),
                ],
              ),
              Text('View and Make Appointments'),
              BlocBuilder<SharedPreferencesCubit, SharedPreferencesState>(
                  bloc: sharedPreferencesCubit,
                  builder: (BuildContext context, SharedPreferencesState state) {
                    return Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.timeslots.length,
                          itemBuilder: (
                            BuildContext context,
                            int idx,
                          ) {
                            // get timeslot status data already exists //
                            final TimeslotData timeslot = state.timeslots[idx];

                            void callback() => timeslot.isBooked ? cancelAppointCallback(timeslot.id) : bookAppointment(timeslot.id);
                            final String actionLabel = timeslot.isBooked ? 'Cancel Appointment' : 'Book Appointment';

                            return AppointmentButton(
                                actionLabel: actionLabel,
                                dateLabel: string_utils.getDateDisplay(timeslot.date),
                                timeLabel: timeslotsDisplay[timeslot.startTime],
                                callback: callback);
                          }),
                    );
                  })
            ],
          ),
        );
      },
    );
  }
}
