import 'package:flutter/material.dart';
import 'package:exsys/model/Ticket.dart';
import 'package:exsys/widgets/TicketCard.dart';
import 'package:dio/dio.dart';

class TicketOptionScreen extends StatefulWidget{
  final List<Ticket> listTicket;
  TicketOptionScreen(this.listTicket);
  @override
  _TicketOptionState createState() => new _TicketOptionState();
}

class _TicketOptionState extends State<TicketOptionScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pilih Tiket'),
          backgroundColor: Colors.greenAccent,
        ),
        body: Container(
          child: ListView.builder(
            itemCount: widget.listTicket.length,
            padding: const EdgeInsets.only(top:10.0),
            itemBuilder: (context, index){
              return TicketCard(ticket: widget.listTicket[index]);
            }
          ),
        )
    );
  }
}