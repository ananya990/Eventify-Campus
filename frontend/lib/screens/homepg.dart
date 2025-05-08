import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/notificationspg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';
import 'calendarpg.dart';
import 'user_profile_page.dart';
import './eventDetailspg.dart';
import 'package:intl/intl.dart';

class EventHome extends StatefulWidget {
  const EventHome({super.key});

  @override
  State<EventHome> createState() => _EventHomeState();
}

class _EventHomeState extends State<EventHome> {
  List<Event> events = [];
  List<Event> filteredEvents = [];
  bool isLoading = true;
  int _currentIndex = 3;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchEvents() async {
    final url = Uri.parse('http://localhost:3000/events');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        setState(() {
          events = data.map((e) => Event.fromJson(e)).toList();
          filteredEvents = events;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterEvents(String query) {
    setState(() {
      filteredEvents =
          events
              .where(
                (event) =>
                    event.title!.toLowerCase().contains(query.toLowerCase()) ||
                    event.location!.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => CalendarPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => NotificationsPage()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const UserProfilePage()),
        );
        break;
      case 3:
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Eventify Campus', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey, size: 18),
                      SizedBox(width: 6),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: filterEvents,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search an Event',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.mic, color: Colors.grey, size: 18),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // Category Buttons
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoryButton(label: 'Coding', isSelected: true),
                      CategoryButton(label: 'CS'),
                      CategoryButton(label: 'Music'),
                      CategoryButton(label: 'Webinar'),
                      CategoryButton(label: 'Art'),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // Event List
                Expanded(
                  child:
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                            itemCount: filteredEvents.length,
                            itemBuilder: (context, index) {
                              return EventCard(event: filteredEvents[index]);
                            },
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _currentIndex == 3 ? Colors.purple : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.home,
                color: _currentIndex == 3 ? Colors.white : Colors.grey,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryButton({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.purple : Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        event.date != null
            ? DateFormat('dd-MM-yyyy').format(DateTime.parse(event.date!))
            : 'Date Unknown';

    return Card(
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDescriptionPage(event: event),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      event.imageUrl ?? 'https://via.placeholder.com/400',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        formattedDate,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                event.title ?? 'Event Title',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                event.location ?? 'Location',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDescriptionPage(event: event),
                    ),
                  );
                },
                child: Text('Register', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
