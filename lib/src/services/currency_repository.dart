import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:currency_exchange_app/src/models/currency_exchange.dart';
import 'package:http/http.dart' as http;

abstract class CurrencyServices {

  Future<CurrencyExchangeRates> fetchCurrency(String currency);
}

class CurrencyExchangeRepository implements CurrencyServices {

  @override
  Future <CurrencyExchangeRates> fetchCurrency(String currency) async{

    http.Response response;

    try {
      response = await http.get("https://api.exchangeratesapi.io/latest?base=$currency");
    } on SocketException {
      throw "Check your Internet Connection";
    }
    catch (_) {
      throw "Not Found";
    }

    var result = jsonDecode(response.body);

    return CurrencyExchangeRates.fromJson(result);
  }
}