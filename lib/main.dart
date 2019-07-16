import 'dart:convert';
import 'dart:math';

import 'package:FukuiEvents/Models/Events.dart';
import 'package:flutter_web/material.dart';
import 'dart:async';
import 'api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FukuiEvents',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
	MyHomePage({Key key, this.title}) : super(key: key);

	final String title;

	@override
	_MyHomePageState createState() => _MyHomePageState();
}

class Debouncer {
	final int milliseconds;
	VoidCallback action;
	Timer _timer;

	Debouncer({this.milliseconds});

	run(VoidCallback action) {
		if (null != _timer) {
			_timer.cancel();
		}
		_timer = Timer(Duration(milliseconds: milliseconds), action);
	}
}

class _MyHomePageState extends State {
  var events = List<Events>();
  final _debouncer = Debouncer(milliseconds: 500);
  var filteredEvents = List<Events>();

  void filterSearchResults(String query) {
	  List<Events> dummySearchList = List<Events>();
	  filteredEvents = events;
	  dummySearchList = events;
	  if(query.isNotEmpty) {
		  dummySearchList = events.where((u) => (
		      u.event_name.toLowerCase().contains(query.toLowerCase()) ||
				  u.category.toLowerCase().contains(query.toLowerCase()) ||
				  u.event_place.toLowerCase().contains(query.toLowerCase()))).toList();
		  setState(() {
			  filteredEvents = dummySearchList;
		  });
		  print(filteredEvents.length);
		  return ;
	  } else {
		  setState(() {
			  filteredEvents = events;
		  });
	  }

  }


  _getEvents(){
		api.getEvents().then((response) {
			setState(() {
				Iterable list = json.decode(utf8.decode(response.bodyBytes));
				events = list.map((model) => Events.fromJson(model)).toList();
				filteredEvents = events;
			});
		});
  }

  @override
  void initState() {
    super.initState();
    _getEvents();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FukuiEvents'),
      ),
      body: Center(
	      child: Column(
		      children: <Widget>[
			      TextField(
				      decoration: InputDecoration(
					      contentPadding: EdgeInsets.all(15.0),
					      hintText: 'Filter...',
				      ),
				      onChanged: (string) {
					      _debouncer.run(() {
						      setState(() {
										filterSearchResults(string);
						      });
					      });
				      },
			      ),
			      Expanded(child: ListView.builder(
				      itemCount: filteredEvents.length,
				      itemBuilder: (context, index){
				      	return Card(
						      child: Column(
							      children: <Widget>[
								      ListTile(
									      title: Text(
										      filteredEvents[index].event_name,
										      style: TextStyle(
											      fontSize: 20.0, fontWeight: FontWeight.bold),
									      ),
									      subtitle: Column(
										      mainAxisAlignment: MainAxisAlignment.start,
										      crossAxisAlignment: CrossAxisAlignment.start,
										      children: <Widget>[
											      Text(
												      filteredEvents[index].event_place,
												      style: TextStyle(
													      fontSize: 16.0,
													      fontWeight: FontWeight.normal),
											      ),
											      Text(
												      filteredEvents[index].start_date,
												      style: TextStyle(
													      fontSize: 14.0,
													      fontWeight: FontWeight.bold),
											      ),
										      ],
									      ),
									      onTap: (){

									      },
								      ),
							      ],
						      ),
					      );
				      },
			      ),
			      )
		      ],
	      ),
      ),
    );
  }
}
