import 'package:exsys/model/Ticket.dart';
import 'package:exsys/screens/TicketOptionScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:exsys/model/Event.dart';

class EventCard extends StatefulWidget {
  final Event event;

  EventCard(this.event);

  @override
  State<StatefulWidget> createState() {
    return EventCardState(event);
  }
}

class EventCardState extends State<EventCard> {
  Event event;
  String renderUrl;

  EventCardState(this.event);

  Widget get eventCard {
    return Card(
        child :Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        child: SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.network("https://picsum.photos/250?image=9"),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                  child: EventDetail(
                    event: this.event,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child:  eventCard,
    );
  }
}

class EventDetail extends StatelessWidget{
  final Event event;
  EventDetail({
    Key key,
    this.event
  }) : super(key: key);
  List<Ticket> _listTicket(){
    List<Ticket> list = []
        ..add(Ticket(
          category: "Presale",
          capacity: 100,
          sold: 0,
          price: 150000,
        ))
      ..add(Ticket(
        category: "Normal",
        capacity: 100,
        sold: 100,
        price: 250000,
      ))
      ..add(Ticket(
        category: "VIP",
        capacity: 20,
        sold: 0,
        price: 350000,
      ));
    return list;
  }
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("id_ID");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat("dd MMMM y","id_ID").format(this.event.start),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                this.event.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                this.event.address,
                style: const TextStyle(
                  fontSize: 8.0,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)
                ),
                onPressed: (){},
                color: Colors.white,
                textColor: Colors.green,
                child: Text(
                  'Details'.toUpperCase()
                )
              ),
              RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(
                      color: Colors.red
                  )
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TicketOptionScreen(_listTicket())));
                },
                color: Colors.red,
                textColor: Colors.white,
                child: Text(
                  'Buy Tickets'.toUpperCase(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

}