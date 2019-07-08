import 'dart:convert';

import 'package:FukuiEvents/Models/Events.dart';
import 'package:flutter_web/material.dart';
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

class _MyHomePageState extends State {
  var events = List<Events>();

  _getEvents(){
		api.getEvents().then((response) {
			setState(() {
				Iterable list = json.decode(utf8.decode(response.bodyBytes));
				events = list.map((model) => Events.fromJson(model)).toList();
			});
		});
  }

  @override
  void initState() {
    // TODO: implement initState
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
	      child: ListView.builder(
		      itemCount: events.length,
		      itemBuilder: (context, index){
		      	return Card(
				      child: Column(
					      children: <Widget>[
					      	ListTile(
							      title: Text(
								      events[index].event_name,
								      style: TextStyle(
									      fontSize: 20.0, fontWeight: FontWeight.bold),
							      ),
							      subtitle: Column(
								      mainAxisAlignment: MainAxisAlignment.start,
								      crossAxisAlignment: CrossAxisAlignment.start,
								      children: <Widget>[
								      	Text(
										      events[index].event_place,
										      style: TextStyle(
											      fontSize: 16.0,
											      fontWeight: FontWeight.normal),
									      ),
									      Text(
										      events[index].start_date,
										      style: TextStyle(
											      fontSize: 14.0,
											      fontWeight: FontWeight.bold),
									      ),
								      ],
							      ),
							      onTap: (){

							      },
						      )
					      ],
				      ),
			      );
		      },
	      )
      )
    );
  }
}
