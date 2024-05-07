import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/blocs/navigation/navigation_cubit.dart';
import '../../data/blocs/shared_preferences/shared_preferences_cubit.dart';
import '../../globals/navigation_enum.dart';
import '../widgets/buttons.dart';
import '../scaffold/core_scaffold.dart';

class Provider extends StatelessWidget {
  const Provider({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationCubit navigationCubit = BlocProvider.of<NavigationCubit>(context);
    SharedPreferencesCubit sharedPreferencesCubit = BlocProvider.of<SharedPreferencesCubit>(context);
    void goToHomeScreen() => navigationCubit.navigate(NavigationEnum.home);
    void goToSchedulerScreen() => navigationCubit.navigate(NavigationEnum.scheduler);
    void createProvider() => sharedPreferencesCubit.createProvider();

    return CoreScaffold(
      BlocBuilder<SharedPreferencesCubit, SharedPreferencesState>(
          bloc: sharedPreferencesCubit,
          builder: (BuildContext context, SharedPreferencesState state) => Column(
                children: [
                  AppButton(
                    label: 'Home',
                    callback: goToHomeScreen,
                  ),
                  if (state.providers.isEmpty) ...[
                    const Text('No providers exists yet click here to create a provider'),
                    AppButton(
                      label: 'New Provider',
                      callback: createProvider,
                    ),
                  ] else ...[
                    const SizedBox(
                      height: 15,
                    ),
                    Text('Current Provider: ${state.providers.first.id}'),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('View and Modify Schedule'),
                    AppButton(
                      label: 'Scheduler',
                      callback: goToSchedulerScreen,
                    ),
                  ],
                ],
              )),
    );
  }
}
