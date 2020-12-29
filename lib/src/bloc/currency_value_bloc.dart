import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyValueCubit extends Cubit<double> {
  CurrencyValueCubit() : super(1.0);

  void changeCurrencyValue(double value) {
    print("coming value $value");
    emit(value);
  }
}
