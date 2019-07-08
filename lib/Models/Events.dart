import 'dart:core';

class Events{
    String event_name;
    String description;
    String remarks;
    String category;
    String start_date;
    String end_date;
    String contact;
    String contact_phone_number;
    String event_place;
    String event_place_url;
    String address;
    String mail_address;
    String transportation;

    Events(String event_name,String description,String remarks, String category, String start_date,String end_date,String contact,String contact_phone_number,String event_place,String event_place_url,String address,String mail_address,String transportation){
        this.event_name = event_name;
        this.description = description;
        this.remarks = remarks;
        this.category = category;
        this.start_date = start_date;
        this.end_date = end_date;
        this.contact = contact;
        this.contact_phone_number = contact_phone_number;
        this.event_place = event_place;
        this.event_place_url = event_place_url;
        this.address = address;
        this.mail_address = mail_address;
        this.transportation = transportation;
    }
    Events.fromJson(Map<String,dynamic> json)
        : event_name = json['event_name'],
            description = json['description'],
            remarks = json['remarks'],
            category = json['category'],
            start_date = json['start_date'],
            end_date = json['end_date'],
            contact = json['contact'],
            contact_phone_number = json['contact_phone_number'],
            event_place = json['event_place'],
            event_place_url = json['event_place_url'],
            address = json['address'],
            mail_address = json['mail_address'],
            transportation = json['transportation'];
}
