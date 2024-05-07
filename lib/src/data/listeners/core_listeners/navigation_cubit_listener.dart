import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../globals/navigation_enum.dart';
import '../../blocs/navigation/navigation_cubit.dart';

BlocListener<NavigationCubit, NavigationEnum> navigationCubitListener(BuildContext context) {
  final NavigatorState navigator = Navigator.of(context);
  return BlocListener<NavigationCubit, NavigationEnum>(
      bloc: BlocProvider.of<NavigationCubit>(context),
      listener: (BuildContext context, NavigationEnum state) async {
        navigator.pushNamedAndRemoveUntil(state.getRoute(), (Route<dynamic> route) => false);
      });
}
