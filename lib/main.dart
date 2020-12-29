import 'package:currency_exchange_app/src/bloc/currency_exchange_bloc.dart';
import 'package:currency_exchange_app/src/bloc/currency_value_bloc.dart';
import 'package:currency_exchange_app/src/bloc/exchange_bloc.dart';
import 'package:currency_exchange_app/src/pages/home_page.dart';
import 'package:currency_exchange_app/src/services/currency_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final CurrencyExchangeRepository repository = CurrencyExchangeRepository();
  runApp(MyApp(
    repository: repository,
  ));
}

class MyApp extends StatelessWidget {
  final CurrencyExchangeRepository repository;

  const MyApp({Key key, @required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      debugShowCheckedModeBanner: false,
      theme: Config.primaryTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CurrencyValueCubit(),
          ),
          BlocProvider(
            create: (context) => CurrencyRateCubit(repository: repository)..fetchCurrency("INR"),
          ),
          BlocProvider(
            create: (context) => CurrencyExchangeCubit(
              repository: repository,
              rateCubit: BlocProvider.of<CurrencyRateCubit>(context),
              valueCubit: BlocProvider.of<CurrencyValueCubit>(context),
            ),
          ),
        ],
        child: HomePage(),
      ),
    );
  }
}

class Config {
  static ThemeData primaryTheme = ThemeData(
      primaryColor: Color(0xff423f74),
      accentColor: Color(0xffaaaaaa),
      primaryIconTheme: IconThemeData(
        color: Color(0xffaaaaaa),
      ),
      primaryTextTheme: TextTheme(
          title: TextStyle(
        color: Color(0xff423f74),
      )),
      appBarTheme: AppBarTheme(
          color: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xffaaaaaa))));
}
