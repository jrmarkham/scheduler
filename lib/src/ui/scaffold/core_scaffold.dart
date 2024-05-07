// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../data/listeners/core_listeners.dart';
import 'core_app_bar.dart';

class CoreScaffold extends StatelessWidget {
  final Widget bodyChild;

  const CoreScaffold(this.bodyChild, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: CoreAppBar(),
      ),
      body: MultiBlocListener(
        listeners: coreBlocListeners(context),
        child: SafeArea(
          child: Padding(padding: const EdgeInsets.all(15), child: bodyChild),
        ),
      ),
    );
  }
}
