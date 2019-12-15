import 'package:exsys/model/Event.dart';
import 'package:exsys/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFF1abc9c, color);
    return MaterialApp(
      title: 'EXSYS',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: colorCustom,
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),
        ),
      ),
      home: ExamplePage(),//MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

Map<int, Color> color =
{
  50:Color.fromRGBO(136,14,79, .1),
  100:Color.fromRGBO(136,14,79, .2),
  200:Color.fromRGBO(136,14,79, .3),
  300:Color.fromRGBO(136,14,79, .4),
  400:Color.fromRGBO(136,14,79, .5),
  500:Color.fromRGBO(136,14,79, .6),
  600:Color.fromRGBO(136,14,79, .7),
  700:Color.fromRGBO(136,14,79, .8),
  800:Color.fromRGBO(136,14,79, .9),
  900:Color.fromRGBO(136,14,79, 1),
};

class ExamplePage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'EXSYS' , style: TextStyle(color: Colors.white, fontFamily: 'Rubik'));
  int _cIndex = 0;

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFF1abc9c, color);
    return
      DefaultTabController(
          length: choices.length,
          child: Scaffold(
              appBar: _buildBar(context),
              body: TabBarView(
                children: choices.map((Choice choice) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ChoiceCard(choice: choice),
                    );
                }).toList(),
              ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _cIndex,
              type: BottomNavigationBarType.shifting ,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.search,color: colorCustom),
                    title: new Text('')
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.confirmation_number,color: colorCustom),
                    title: new Text('')
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.center_focus_weak,color: colorCustom),
                    title: new Text('')
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_balance_wallet,color: colorCustom),
                    title: new Text('')
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_box,color: colorCustom),
                    title: new Text('')
                ),
              ],
              onTap: (index){
                _incrementTab(index);

              },
            ),
            resizeToAvoidBottomPadding: false,
          ),
      );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
      bottom: TabBar(
        isScrollable: true,
        tabs: choices.map((Choice choice) {
          return Tab(
            text: choice.title,
      //                        icon: Icon(choice.icon),
          );
        }).toList(),
        labelColor: Colors.white,
        labelStyle: TextStyle(fontFamily: 'Rubik'),
      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: () => print(filteredNames[index]['name']),
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close,color: Colors.white,);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search,color: Colors.white,),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search,color: Colors.white,);
        this._appBarTitle = new Text( 'EXSYS'  ,style: TextStyle(color: Colors.white));
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    final response = await dio.get('https://swapi.co/api/people');
    List tempList = new List();
    for (int i = 0; i < response.data['results'].length; i++) {
      tempList.add(response.data['results'][i]);
    }
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: Column(
//          // Column is also layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Home', icon: Icons.home),
  const Choice(title: 'Terdekat', icon: Icons.near_me),
  const Choice(title: 'Terbaru', icon: Icons.new_releases),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    List<Event> listEvent = []
      ..add(Event(
        start: DateTime.now(),
        name:"PEKAN RAYA SUMATERA UTARA 2020",
        address:"Jalan Gatot Subroto No. 1, Medan",
        vote: 50))
      ..add(Event(
          start: DateTime.now(),
          name:"PEKAN RAYA SUMATERA UTARA 2020",
          address:"Jalan Gatot Subroto No. 1, Medan",
          vote: 50));

//      ..add(Event(DateTime.now(),"PEKAN RAYA SUMATERA UTARA 2020","Jalan Gatot Subroto No. 1, Medan",50))
//    ..add(Event(DateTime.now(),"PEKAN RAYA SUMATERA UTARA 2020","Jalan Gatot Subroto No. 1, Medan",50));
    return HomeScreen(listEvent
    );
//    return
//      Card(
//      color: Colors.white,
//      child: Center(
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Icon(choice.icon, size: 128.0, color: textStyle.color),
//            Text(choice.title, style:textStyle,),
//          ],
//        ),
//      ),
//    );
  }
}