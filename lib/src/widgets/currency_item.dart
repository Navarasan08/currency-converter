import 'package:currency_exchange_app/src/bloc/currency_value_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyItem extends StatefulWidget {
  final bool selected;
  final String currency;
  final double rate;
  final Widget trailing;


  CurrencyItem({Key key,
    this.selected = false,
    this.currency,
    this.rate, this.trailing,
   })
      : super(key: key);

  @override
  _CurrencyItemState createState() => _CurrencyItemState();
}

class _CurrencyItemState extends State<CurrencyItem> {
  Color accent = Color(0xffaaaaaa);
  TextEditingController controller;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final bloc = BlocProvider.of<CurrencyValueCubit>(context, listen: false);
    controller = new TextEditingController(text: "${bloc.state}");
    controller.addListener(() {
      print("Sending value ${double.parse(controller?.text ?? 0)}");
      bloc.changeCurrencyValue(double.parse(controller?.text ?? 0));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: EdgeInsets.only(left: 20.0),
          height: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(
                color: widget.selected ? Theme
                    .of(context)
                    .primaryColor : accent),
          ),
          child: Row(
            children: [
              Container(
                height: 50.0,
                child: Row(
                  children: [
                    Container(
                      height: 20.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                          'icons/flags/png/${widget.currency.substring(0, 2)
                              .toLowerCase()}.png',
                          package: 'country_icons'),
                    ),
                    SizedBox(width: 6.0),
                    Text(widget.currency),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: accent,
                        size: 18.0,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 50.0,
                  padding: EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                      border: Border(right: BorderSide(color: accent))),
                  child: widget.selected
                      ? TextField(
                    controller: controller,
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      suffixText: "\$",
                    ),
                  )
                      : Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${widget.rate * context.watch<CurrencyValueCubit>().state} \$",
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),

              widget.trailing,
            ],
          )),
    );
  }
}
