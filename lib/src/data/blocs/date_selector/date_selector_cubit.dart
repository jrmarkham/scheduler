import 'package:flutter_bloc/flutter_bloc.dart';

class DateSelectorCubit extends Cubit<DateTime?> {
  DateSelectorCubit() : super(null);

  selectDate(DateTime dateTime) => emit(dateTime);
}
