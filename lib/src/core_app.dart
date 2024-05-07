// Dart imports

// Project imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/src/ui/screens/appointment.dart';
import 'package:scheduler/src/ui/screens/scheduler.dart';

import 'data/blocs/navigation/navigation_cubit.dart';
import 'data/blocs/shared_preferences/shared_preferences_cubit.dart';
import 'globals/theme.dart';
import 'ui/screens/client.dart';
import 'ui/screens/home.dart';
import 'ui/screens/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class CoreAppBlocWrapper extends StatelessWidget {
  const CoreAppBlocWrapper({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(providers: [
        BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
        BlocProvider<SharedPreferencesCubit>(create: (BuildContext context) => SharedPreferencesCubit()),
      ], child: const CoreApp());
}

class CoreApp extends StatelessWidget {
  const CoreApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        title: 'The Scheduler',
        theme: mainTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Home(),
          '/provider': (context) => const Provider(),
          '/scheduler': (context) => const Scheduler(),
          '/appointment': (context) => const Appointment(),
          '/client': (context) => const Client()
        },
      );
}
