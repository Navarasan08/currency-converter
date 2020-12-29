import 'package:bloc/bloc.dart';
import 'package:currency_exchange_app/src/models/exchange_countries.dart';
import 'package:currency_exchange_app/src/services/currency_repository.dart';
import 'package:meta/meta.dart';

import 'currency_exchange_bloc.dart';
import 'currency_value_bloc.dart';

class CurrencyExchangeCubit extends Cubit<List<ExchangeCountry>> {
  final CurrencyExchangeRepository repository;
  CurrencyRateCubit rateCubit;
  CurrencyValueCubit valueCubit;
  bool isLoading = false;

  CurrencyExchangeCubit(
      {@required this.repository, this.rateCubit, this.valueCubit})
      : assert(repository != null),
        super([ExchangeCountry("INR", 1.0)]);

  void addCountry(String currency) {
    isLoading = true;
    ExchangeCountry exchangeCountry;
    rateCubit.state.exchangeRates.forEach((country) {
      if (country.currency == currency) {
        exchangeCountry = ExchangeCountry(currency, country.rate);
      }
    });
    isLoading = false;
    emit([...state, exchangeCountry]);
  }

  void reorderCountries(List<ExchangeCountry> countries) async {
    if (countries[0].currency != state[0].currency) {
      await rateCubit.fetchCurrency(countries[0].currency);
      countries.forEach((country) {
        rateCubit.state.exchangeRates.forEach((rate) {
          if (country.currency == rate.currency) {
            country.rate = rate.rate;
          }
        });
      });

    }
    emit(countries);
  }
}
