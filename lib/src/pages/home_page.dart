import 'dart:ui';

import 'package:currency_exchange_app/src/bloc/currency_exchange_bloc.dart';
import 'package:currency_exchange_app/src/bloc/exchange_bloc.dart';
import 'package:currency_exchange_app/src/models/exchange_countries.dart';
import 'package:currency_exchange_app/src/widgets/currency_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  showCountries(BuildContext context) {
    showAlertDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person_outline_rounded),
          onPressed: () {},
        ),
        title: Text("Convert"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_alert_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child:
                    BlocConsumer<CurrencyExchangeCubit, List<ExchangeCountry>>(
                        listener: (context, state) {
                  if (state != null) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Currency Updated"),
                    ));
                  }

                  if (state.isEmpty) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Add New Country"),
                    ));
                  }
                }, builder: (context, state) {
                  if (state == null) {
                    return Text("No Currency Found");
                  }
                  print(state.length);

                  return ImplicitlyAnimatedReorderableList<ExchangeCountry>(
                    items: state,
                    areItemsTheSame: (oldItem, newItem) =>
                        oldItem.currency == newItem.currency,
                    onReorderFinished: (item, from, to, newItems) {
                      BlocProvider.of<CurrencyExchangeCubit>(context)
                          .reorderCountries(newItems);
                    },
                    itemBuilder: (context, itemAnimation, item, index) {
                      return Reorderable(
                        key: ValueKey(item),
                        builder: (context, dragAnimation, inDrag) {
                          final t = dragAnimation.value;
                          final elevation = lerpDouble(0, 8, t);
                          final color = Color.lerp(
                              Colors.white, Colors.white.withOpacity(0.8), t);

                          return SizeFadeTransition(
                            sizeFraction: 0.7,
                            curve: Curves.easeInOut,
                            animation: itemAnimation,
                            child: Material(
                              color: color,
                              elevation: elevation,
                              type: MaterialType.transparency,
                              child: CurrencyItem(
                                key: ValueKey(state[index]),
                                currency: state[index].currency,
                                rate: state[index].rate,
                                selected: index == 0,
                                trailing: Handle(
                                  delay: const Duration(milliseconds: 100),
                                  child: IconButton(
                                    icon: Icon(
                                        index == 0
                                            ? Icons.calculate
                                            : Icons.more_vert_sharp,
                                        size: 25.0,
                                        color: Color(0xffaaaaaa)),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
              ),
              Container(
                width: double.infinity,
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  child: Text("Add another currency"),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    showCountries(context);
                  },
                ),
              ),
              SizedBox(height: 6.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Live mid-market rate",
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                Icon(Icons.info_outline,
                    size: 16.0, color: Theme.of(context).primaryColor),
              ]),
              SizedBox(height: 3.0),
              Text("To see our send rates, click on quote", style: TextStyle()),
            ],
          )),
    );
  }
}

//
// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   showCountries(BuildContext context) {
//     showAlertDialog(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.person_outline_rounded),
//           onPressed: () {},
//         ),
//         title: Text("Convert"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add_alert_rounded),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Container(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 BlocConsumer<CurrencyExchangeCubit, List<ExchangeCountry>>(
//                     listener: (context, state) {
//                   if (state != null) {
//                     Scaffold.of(context).showSnackBar(SnackBar(
//                       content: Text("Currency Added"),
//                     ));
//                   }
//
//                   if (state.isEmpty) {
//                     Scaffold.of(context).showSnackBar(SnackBar(
//                       content: Text("Add New Country"),
//                     ));
//                   }
//                 }, builder: (context, state) {
//                   if (state == null) {
//                     return Text("No Currency Found");
//                   }
//                   print(state.length);
//
//                   return Column(
//                     children: state.map(
//                       (country) {
//                         int index = state.indexOf(country);
//                         return CurrencyItem(
//                           currency: country.currency,
//                           rate: country.rate,
//                           selected: index == 0,
//                         );
//                       },
//                     ).toList(),
//                   );
//                 }),
//                 Container(
//                   width: double.infinity,
//                   child: OutlineButton(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(7.0)),
//                     child: Text("Add another currency"),
//                     borderSide:
//                         BorderSide(color: Theme.of(context).primaryColor),
//                     textColor: Theme.of(context).primaryColor,
//                     onPressed: () {
//                       showCountries(context);
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 6.0),
//                 Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                   Text("Live mid-market rate",
//                       style: TextStyle(color: Theme.of(context).primaryColor)),
//                   Icon(Icons.info_outline,
//                       size: 16.0, color: Theme.of(context).primaryColor),
//                 ]),
//                 SizedBox(height: 3.0),
//                 Text("To see our send rates, click on quote",
//                     style: TextStyle()),
//               ],
//             ),
//           )),
//     );
//   }
// }

showAlertDialog(BuildContext context) {
  Widget okButton = FlatButton(
    child: Text("Ok"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  final bloc = BlocProvider.of<CurrencyRateCubit>(context);

  AlertDialog alert = AlertDialog(
    title: Text("Choose Country"),
    content: SingleChildScrollView(
      child: Column(
        children: bloc.state.exchangeRates
            .map((rate) => ListTile(
                  leading: Image.asset(
                      'icons/flags/png/${rate.currency.substring(0, 2).toLowerCase()}.png',
                      width: 20.0,
                      height: 20.0,
                      package: 'country_icons'),
                  title: Text(rate.currency),
                  onTap: () {
                    BlocProvider.of<CurrencyExchangeCubit>(context)
                        .addCountry(rate.currency);
                    Navigator.pop(context);
                  },
                ))
            .toList(),
      ),
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
