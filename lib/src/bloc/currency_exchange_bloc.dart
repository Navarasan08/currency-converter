import 'package:currency_exchange_app/src/models/currency_exchange.dart';
import 'package:currency_exchange_app/src/services/currency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyRateCubit extends Cubit<CurrencyExchangeRates> {
  final CurrencyExchangeRepository repository;

  CurrencyRateCubit({this.repository}) : super(null);

  void fetchCurrency(String country) async{
    CurrencyExchangeRates rates = await repository.fetchCurrency(country);
    emit(rates);
  }

}
