import 'package:FukuiEvents/Models/Events.dart';
import 'package:flutter_web/material.dart';

class Detail extends StatelessWidget {
	final Events _events;

	Detail(this._events);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Detail'),
			),
			body: ListView(children: [
				Container(
					margin: const EdgeInsets.all(16.0),
					child: Text(_events.event_name,
						style: TextStyle(
							fontSize: 20.0,
							fontWeight: FontWeight.bold,
						))),
				Container(
					margin: const EdgeInsets.all(16.0),
					child: Text(_events.description,
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.normal,
						))),
				Container(
					margin: const EdgeInsets.all(16.0),
					child: Text(_events.remarks,
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.normal,
						))),
				Container(
					margin: const EdgeInsets.all(16.0),
					child: Text(_events.category,
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.normal,
						))),
				Container(
					margin: const EdgeInsets.all(16.0),
					child: Text(_events.start_date,
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.normal,
						))),
				Container(
					margin: const EdgeInsets.all(16.0),
					child: Text(_events.end_date,
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.normal,
						))),
				Container(
					margin: const EdgeInsets.all(16.0),
					child: Text(_events.contact,
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.normal,
						))),
				Container(
					margin: const EdgeInsets.all(16.0),
					child: Text(_events.contact_phone_number,
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.normal,
						))),
				Container(
					margin: const EdgeInsets.all(16.0),
					child: Text(_events.event_place,
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.normal,
						))),
				Container(
					margin: const EdgeInsets.all(16.0),
					child: Text(_events.event_place_url,
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.normal,
						))),
				Container(
					margin: const EdgeInsets.all(16.0),
					child: Text(_events.address,
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.normal,
						))),
				Container(
					margin: const EdgeInsets.all(16.0),
					child: Text(_events.mail_address,
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.normal,
						))),
			]));
	}
}
