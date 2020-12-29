import 'package:currency_exchange_app/src/bloc/currency_exchange_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.read<CurrencyRateCubit>().state;
    return Container(
      child: Column(
        children: [
          ...(state.exchangeRates.map((rate) => Text(rate.currency))),
        ],
      ),
    );
  }
}
