import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/src/data/blocs/navigation/navigation_cubit.dart';
import 'package:scheduler/src/globals/navigation_enum.dart';
import 'package:scheduler/src/globals/theme.dart';
import 'package:scheduler/src/ui/widgets/buttons.dart';

import '../scaffold/core_scaffold.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationCubit navigationCubit = BlocProvider.of<NavigationCubit>(context);
    void goToProviderScreen() => navigationCubit.navigate(NavigationEnum.provider);
    void goToClientScreen() => navigationCubit.navigate(NavigationEnum.client);
    return CoreScaffold(Column(
      children: [
        Text('Click to got Provider Screen', style: mainTheme.textTheme.bodyMedium),
        AppButton(
          label: 'Provider',
          callback: goToProviderScreen,
        ),
        const SizedBox(
          height: 50,
        ),
        Text('Click to got Client Screen', style: mainTheme.textTheme.bodyMedium),
        AppButton(
          label: 'Client',
          callback: goToClientScreen,
        ),
      ],
    ));
  }
}
