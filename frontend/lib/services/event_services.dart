import 'dart:convert';
import 'package:http/http.dart' as http;
import 'event_model.dart';

Future<List<Event>> fetchTodaysEvents() async {
  try {
    // Replace with your actual backend URL
    final response = await http.get(Uri.parse('http://localhost:3000/events/today'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((eventJson) => Event.fromJson(eventJson)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  } catch (e) {
    throw Exception('Error fetching events: $e');
  }
}
