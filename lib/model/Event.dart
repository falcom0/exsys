import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Event {
//  final DocumentReference reference;
  DateTime start;
  String name;
  String address;
  int vote;

  Event({Key key,this.start,this.name,this.address,this.vote});
//  Event.data(this.reference,
//      [this.name,
//        this.vote]) {
//    // Set these rather than using the default value because Firebase returns
//    // null if the value is not specified.
//    this.name ??= 'Frank';
//    this.vote ??= 7;
//  }
//
//  factory Event.from(DocumentSnapshot document) => Event.data(
//      document.reference,
//      document.data['name'],
//      document.data['vote']);
//
//  void save() {
//    reference.setData(toMap());
//  }
//
//  Map<String, dynamic> toMap() {
//    return {
//      'name': name,
//      'vote': vote,
//    };
//  }
}