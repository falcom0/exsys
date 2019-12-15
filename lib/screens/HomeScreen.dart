import 'package:flutter/material.dart';
import 'package:exsys/model/Event.dart';
import 'package:exsys/widgets/EventCard.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget{
  final List<Event> allEvent;

  HomeScreen(this.allEvent);
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: widget.allEvent.length,
          padding: const EdgeInsets.only(top: 10.0),
          itemBuilder: (context, index){
            return EventCard(widget.allEvent[index]);
          },
        ),
      ),
    );
  }
}