import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../globals/navigation_enum.dart';

class NavigationCubit extends Cubit<NavigationEnum> {
  NavigationCubit() : super(NavigationEnum.home);

  navigate(NavigationEnum nav) => emit(nav);
}
