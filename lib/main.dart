import 'dart:convert';
import 'dart:math';

import 'package:FukuiEvents/Models/Events.dart';
import 'package:FukuiEvents/Models/Category.dart';
import 'package:flutter_web/material.dart';
import 'dart:async';
import 'api.dart';
import 'detail.dart';

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
  final _category = Category();

  void filterSearchResults(String query) {
	  List<Events> dummySearchList = List<Events>();
	  List<Events> dummyCategoryList = List<Events>();
	  filteredEvents = events;
	  dummySearchList = events;
	  if (query.isNotEmpty && query != null) {
		  dummySearchList = events.where((u) =>
		  (
			  u.event_name.toLowerCase().contains(query.toLowerCase()) ||
				  u.category.toLowerCase().contains(query.toLowerCase()) ||
				  u.event_place.toLowerCase().contains(query.toLowerCase()))).toList();
		  setState(() {
			  filteredEvents = dummySearchList;
		  });
		  print(filteredEvents.length);
		  return;
	  } else {
		  setState(() {
		  	_category.events_category.forEach((category,checked){
		  		if(checked){
		  			dummyCategoryList.addAll(filteredEvents.where((u) =>(
					    u.category.toLowerCase().contains(category)
					  )).toList());
				  }
			  });
		  	filteredEvents = dummyCategoryList;
		  });
	  }
  }


  _displayDialog(BuildContext context) async{
	  return showDialog(
		  context: context,
		  builder: (context) {
			  return AlertDialog(
				  content: Column (
					  crossAxisAlignment: CrossAxisAlignment.stretch,
					  mainAxisSize: MainAxisSize.min,
					  children: <Widget>[
						  CheckboxListTile(
							  title: Text(Category.history),
							  value: _category.events_category[Category.history],
							  onChanged: (val) => {
								  setState(() {
									  _category.events_category[Category.history] = val;
									  Navigator.of(context).pop();
									  _displayDialog(context);
								  })
							  },
						  ),
						  CheckboxListTile(
							  title: Text(Category.nature),
							  value: _category.events_category[Category.nature],
							  onChanged: (val) => {
								  setState(() {
									  _category.events_category[Category.nature] = val;
									  Navigator.of(context).pop();
									  _displayDialog(context);
								  })
							  },
						  ),
						  CheckboxListTile(
							  title: Text(Category.seminar),
							  value: _category.events_category[Category.seminar],
							  onChanged: (val) => {
								  setState(() {
									  _category.events_category[Category.seminar] = val;
									  Navigator.of(context).pop();
									  _displayDialog(context);
								  })
							  },
						  ),
						  CheckboxListTile(
							  title: Text(Category.kids),
							  value: _category.events_category[Category.kids],
							  onChanged: (val) => {
								  setState(() {
									  _category.events_category[Category.kids] = val;
									  Navigator.of(context).pop();
									  _displayDialog(context);
								  })
							  },
						  ),
						  CheckboxListTile(
							  title: Text(Category.other),
							  value: _category.events_category[Category.other],
							  onChanged: (val) => {
								  setState(() {
									  _category.events_category[Category.other] = val;
									  Navigator.of(context).pop();
									  _displayDialog(context);
								  })
							  },
						  ),
						  CheckboxListTile(
							  title: Text(Category.culture),
							  value: _category.events_category[Category.culture],
							  onChanged: (val) => {
								  setState(() {
									  _category.events_category[Category.culture] = val;
									  Navigator.of(context).pop();
									  _displayDialog(context);
								  })
							  },
						  ),
						  CheckboxListTile(
							  title: Text(Category.health),
							  value: _category.events_category[Category.health],
							  onChanged: (val) => {
								  setState(() {
									  _category.events_category[Category.health] = val;
									  Navigator.of(context).pop();
									  _displayDialog(context);
								  })
							  },
						  ),
						  CheckboxListTile(
							  title: Text(Category.sports),
							  value: _category.events_category[Category.sports],
							  onChanged: (val) => {
								  setState(() {
									  _category.events_category[Category.sports] = val;
									  Navigator.of(context).pop();
									  _displayDialog(context);
								  })
							  },
						  ),
						  CheckboxListTile(
							  title: Text(Category.music),
							  value: _category.events_category[Category.music],
							  onChanged: (val) => {
								  setState(() {
									  _category.events_category[Category.music] = val;
									  Navigator.of(context).pop();
									  _displayDialog(context);
								  })
							  },
						  ),
						  CheckboxListTile(
							  title: Text(Category.festival),
							  value: _category.events_category[Category.festival],
							  onChanged: (val) => {
								  setState(() {
									  _category.events_category[Category.festival] = val;
									  Navigator.of(context).pop();
									  _displayDialog(context);
								  })
							  },
						  ),
					  ],
				  ),
				  title: Text("表示カテゴリ設定"),
				  actions: <Widget>[
					  FlatButton(
						  child: Text("OK"),
						  onPressed: () {
							  _debouncer.run(() {
								  setState(() {
									  filterSearchResults('');
								  });
							  });
							  Navigator.pop(context);
						  }
					  ),
				  ],
			  );
		  },
	  );
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
  void dispose() {
	  // Clean up the controller when the widget is removed from the
	  // widget tree.
	  super.dispose();
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
					      prefixIcon: IconButton(
						      icon: Icon(Icons.category),
						      onPressed: (){
										_displayDialog(context);
						      },
					      ),
				      ),
				      onChanged: (text) {
					      _debouncer.run(() {
						      setState(() {
										filterSearchResults(text);
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
													Navigator.push(context, MaterialPageRoute<Null>(
														settings: const RouteSettings(name: "/detail"),
														builder: (BuildContext context) => Detail(filteredEvents[index])
													));
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
