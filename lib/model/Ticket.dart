import 'package:flutter/material.dart';
class Ticket {
  int capacity;
  int price;
  int sold;
  int discount;
  String category;

  Ticket({Key key, this.capacity, this.price, this.sold, this.discount, this.category});
}