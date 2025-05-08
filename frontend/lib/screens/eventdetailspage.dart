import 'package:flutter/material.dart';
import './eventdetailspage2.dart';
import './calendarpg.dart';
import 'notificationspg.dart';
import './user_profile_page.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  int _currentIndex = 3;

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
        // Already on Home, no action needed
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // Dark background for the whole page
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        centerTitle: true,
        title: const Text(
          'Eventify Campus',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Event Details',
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Event Name',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'By - Club Name',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Date, Time',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 2),
            const Text(
              'Offline, Rn 128, Old Building, NCU',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 18,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: const Color.fromARGB(
                          255,
                          178,
                          191,
                          211,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: const Color.fromARGB(255, 154, 168, 187),
                    ),
                  ],
                ),
                const SizedBox(width: 22),
                const Text(
                  '+20 registered',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  textStyle: const TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EventDetailsPage2(),
                    ),
                  );
                },
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _currentIndex == 3 ? Colors.purple : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.home,
                color: _currentIndex == 3 ? Colors.white : Colors.grey[400],
              ),
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
