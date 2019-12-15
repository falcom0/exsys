import 'dart:ffi';

import 'package:exsys/model/Ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TicketCard extends StatelessWidget{
  Ticket ticket;
  TicketCard({Key key, this.ticket}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        child: SizedBox(
          height: 150,
          width: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.network("https://picsum.photos/id/237/200/300"),
              ),
              Expanded(
                flex: 1,
                child: Padding(padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this.ticket.category,
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),
                      this.ticket.capacity - this.ticket.sold > 0 ?
                        Row(
                          children: <Widget>[
                            Icon(Icons.trip_origin, color: Colors.green,),
                            Text("Available",
                              style: TextStyle(color: Colors.black),)
                            ],
                        ) :
                        Row(
                          children: <Widget>[
                            Icon(Icons.trip_origin, color: Colors.red,),
                            Text("Sold Out",
                              style: TextStyle(color: Colors.black),)
                          ],
                        ),
                      SizedBox(height: 50,),
                      Center(
                        child: this.ticket.capacity - this.ticket.sold > 0 ?
                          RaisedButton(
                            padding: EdgeInsets.only(left: 50.0, right: 50.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                            onPressed: (){},
                            color: Colors.greenAccent,
                            textColor: Colors.white,
                            child: Text(
                                FlutterMoneyFormatter(
                                    amount: this.ticket.price.toDouble(),
                                    settings: MoneyFormatterSettings(
                                        symbol: 'IDR',
                                        thousandSeparator: '.',
                                        decimalSeparator: ',',
                                        fractionDigits: 0,
                                        compactFormatType: CompactFormatType.long
                                    )
                                ).output.symbolOnLeft
                            ),
                          ):
                        RaisedButton(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                          onPressed: (){},
                          color: Colors.black38,
                          textColor: Colors.white,
                          child: Text(
                              FlutterMoneyFormatter(
                                  amount: this.ticket.price.toDouble(),
                                  settings: MoneyFormatterSettings(
                                      symbol: 'IDR',
                                      thousandSeparator: '.',
                                      decimalSeparator: ',',
                                      fractionDigits: 0,
                                      compactFormatType: CompactFormatType.long
                                  )
                              ).output.symbolOnLeft
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

}