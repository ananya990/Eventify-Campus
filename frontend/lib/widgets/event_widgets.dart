import 'package:flutter/material.dart';
import 'event_model.dart';

Widget EventCardFromModel(Event event) {
  return Card(
    color: Colors.grey[800],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(event.date, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text(event.location, style: TextStyle(color: Colors.grey)),
        ],
      ),
    ),
  );
}
