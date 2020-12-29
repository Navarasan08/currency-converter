
class CurrencyExchangeRate {
  final String currency;
  final double rate;

  CurrencyExchangeRate(this.currency, this.rate);

  factory CurrencyExchangeRate.fromJson(String currency, double rate) {
    return CurrencyExchangeRate(currency, rate);
  }
}

class CurrencyExchangeRates {
  final List<CurrencyExchangeRate> exchangeRates;
  final String date;
  final String base;

  CurrencyExchangeRates({this.exchangeRates, this.date, this.base});

  factory CurrencyExchangeRates.fromJson(Map<String, dynamic> json) {
    return CurrencyExchangeRates(
      exchangeRates: (json['rates'] as Map<String, dynamic>)
          .entries
          .map((e) =>
              e == null ? null : CurrencyExchangeRate.fromJson(e.key, e.value as double))
          ?.toList(),
      date: json['date'] as String,
      base: json['base'] as String,
    );
  }
}
