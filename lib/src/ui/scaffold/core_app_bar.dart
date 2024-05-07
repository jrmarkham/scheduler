// Flutter imports:

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/blocs/navigation/navigation_cubit.dart';
import '../../globals/navigation_enum.dart';
import '../../globals/theme.dart';

class CoreAppBar extends StatelessWidget {
  const CoreAppBar({super.key});

  // get a default height
  // get theme and functions for nav

  @override
  Widget build(BuildContext context) {
    final NavigationCubit navigationCubit = BlocProvider.of<NavigationCubit>(context);
    void navigationCallback(NavigationEnum nav) => navigationCubit.navigate(nav);
    return BlocBuilder<NavigationCubit, NavigationEnum>(
        bloc: navigationCubit,
        builder: (BuildContext context, NavigationEnum state) {
          return SafeArea(
            child: AppBar(
              // true on tablets
              centerTitle: false,
              backgroundColor: Colors.transparent,
              title: Text(state.name.toUpperCase(), style: mainTheme.textTheme.labelLarge),
              leading: NavIconButton(
                nav: NavigationEnum.home,
                isActive: state == NavigationEnum.home,
                navigationCallback: () => navigationCallback(NavigationEnum.home),
              ),
            ),
          );
        });
  }
}

class NavIconButton extends StatelessWidget {
  final NavigationEnum nav;
  final bool isActive;
  final VoidCallback navigationCallback;

  const NavIconButton({required this.nav, required this.isActive, required this.navigationCallback, super.key});

  @override
  Widget build(BuildContext context) => isActive
      ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.home,
            color: mainTheme.textTheme.bodyMedium?.color,
            size: 25,
          ),
        )
      : IconButton(icon: Icon(Icons.home, color: mainTheme.iconTheme.color, size: 30), onPressed: navigationCallback);
}
