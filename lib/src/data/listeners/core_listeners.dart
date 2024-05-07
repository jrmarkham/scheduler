// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:

import 'core_listeners/navigation_cubit_listener.dart';

List<BlocListener<dynamic, dynamic>> coreBlocListeners(BuildContext context) => <BlocListener<dynamic, dynamic>>[
      navigationCubitListener(context),
    ];
