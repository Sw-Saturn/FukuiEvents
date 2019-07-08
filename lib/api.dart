import 'dart:async';
import 'package:http/http.dart'as http;


const baseUrl = "https://raw.githubusercontent.com/jigjp/intern_exam/master/fukui_event.json";

class api {
    static Future getEvents(){
        return http.get(baseUrl);
    }
}
