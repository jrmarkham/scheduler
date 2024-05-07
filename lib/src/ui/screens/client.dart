import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/src/data/blocs/shared_preferences/shared_preferences_cubit.dart';

import '../../data/blocs/navigation/navigation_cubit.dart';
import '../../globals/navigation_enum.dart';
import '../widgets/buttons.dart';
import '../scaffold/core_scaffold.dart';

class Client extends StatelessWidget {
  const Client({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationCubit navigationCubit = BlocProvider.of<NavigationCubit>(context);
    SharedPreferencesCubit sharedPreferencesCubit = BlocProvider.of<SharedPreferencesCubit>(context);
    void goToHomeScreen() => navigationCubit.navigate(NavigationEnum.home);
    void goToAppointmentsScreen() => navigationCubit.navigate(NavigationEnum.appointment);

    void createClient() => sharedPreferencesCubit.createClient();

    return CoreScaffold(
      BlocBuilder<SharedPreferencesCubit, SharedPreferencesState>(
          bloc: sharedPreferencesCubit,
          builder: (BuildContext context, SharedPreferencesState state) => Column(
                children: [
                  AppButton(
                    label: 'Home',
                    callback: goToHomeScreen,
                  ),
                  if (state.clients.isEmpty) ...[
                    const Text('No clients exists yet click here to create a client'),
                    AppButton(
                      label: 'New Client',
                      callback: createClient,
                    ),
                  ] else ...[
                    Text('Current Client: ${state.clients.first.id}'),
                    if (state.timeslots.isEmpty) ...[
                      const Text('No timeslots exists yet check back later'),
                    ] else ...[
                      const Text('View or Book an appointment'),
                      // show current appointments
                      AppButton(
                        label: 'Appointments',
                        callback: goToAppointmentsScreen,
                      ),
                      // show make an appointment
                    ]
                  ],
                ],
              )),
    );
  }
}
