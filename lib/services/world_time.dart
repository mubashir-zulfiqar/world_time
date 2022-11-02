import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location, // Location Name for the UI
      time, // The time in that location
      flagIconUrl, // url to an asset flag icon
      url; // location url for api endpoint

  WorldTime(this.location, this.flagIconUrl, this.url);

  Future<void> getTime() async {
    try {
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3 );

      DateTime dateTimeNow = DateTime.parse(datetime);
      dateTimeNow = dateTimeNow.add(Duration(hours: int.parse(offset)));

      // set the time of the property
      time = DateFormat.jm().format(dateTimeNow);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      time = 'could not get time data';
    }
  }
}