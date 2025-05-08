class Event {
  final String title;
  final String date;
  final String time;
  final String location;
  final String description;
  final String imageUrl;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'] ?? 'Untitled Event',
      date: json['date'] ?? 'Unknown Date',
      time: json['time'] ?? 'Unknown Time',
      location: json['location'] ?? 'No location specified',
      description: json['description'] ?? 'No description available.',
      imageUrl:
          json['image_url'] ??
          'https://via.placeholder.com/300x150.png?text=No+Image',
    );
  }
}
