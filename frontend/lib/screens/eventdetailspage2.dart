import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_application_2/screens/homepg.dart';
import 'package:flutter_application_2/screens/eventdetailspage.dart';
import 'package:flutter_application_2/screens/notificationspg.dart';
import 'package:flutter_application_2/screens/calendarpg.dart';
import 'package:flutter_application_2/screens/user_profile_page.dart';

class EventDetailsPage2 extends StatefulWidget {
  const EventDetailsPage2({Key? key}) : super(key: key);

  @override
  State createState() => _EventDetailsPage2State();
}

class _EventDetailsPage2State extends State<EventDetailsPage2> {
  int registeredCount = 21;
  bool _showPopup = false;
  int _currentIndex = 3; // Home is the default selected index

  void _onBackPressed() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const EventHome()));
  }

  void _onUnregister() {
    setState(() {
      if (registeredCount > 0) registeredCount--;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Unregistered from event')));
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const EventDetailsPage()));
  }

  void _togglePopup() {
    setState(() {
      _showPopup = !_showPopup;
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
    const purple700 = Colors.purple;
    const gray400 = Color(0xFF374151); // Darker gray for dark mode
    const gray600 = Color(0xFF9CA3AF); // Light gray text
    const whiteText = Colors.white;
    const blackText = Colors.black;

    return Scaffold(
      backgroundColor: Colors.black87, // Dark background for dark mode
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 1,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: _onBackPressed,
          tooltip: 'Back',
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Placeholder image
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://rukminim2.flixcart.com/image/850/1000/l01blow0/poster/2/w/z/medium-music-wallpaper-on-fine-art-paper-theme-images-hd-original-imagbx2phbqcnzym.jpeg?q=90&crop=false',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Event Info
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Music Fest 2025',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: whiteText, // White text for dark mode
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'By - MusixIN',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: gray600, // Light gray text for dark mode
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '31-05-2025, 4:30 onwards',
                        style: TextStyle(fontSize: 14, color: whiteText),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Open Grounds',
                        style: TextStyle(fontSize: 14, color: whiteText),
                      ),
                      const SizedBox(height: 12),
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
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  154,
                                  168,
                                  187,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 22),
                          Text(
                            '+$registeredCount registered',
                            style: const TextStyle(
                              fontSize: 14,
                              color: whiteText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Description
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 14, color: whiteText),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Join top innovators, developers, and entrepreneurs for a day of tech talks, networking, and startup showcases.',
                        style: TextStyle(
                          fontSize: 14,
                          color: whiteText,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _onUnregister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Text(
                        'Unregister',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 24),
                    ElevatedButton(
                      onPressed: _togglePopup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Text(
                        'View QR',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          if (_showPopup) ...[
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.black.withOpacity(0.4)),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 48,
                ),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(24),
                ),
                constraints: const BoxConstraints(maxWidth: 400),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: _togglePopup,
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedTextKit(
                          isRepeatingAnimation: false,
                          animatedTexts: [
                            TyperAnimatedText(
                              'Hey,\nName',
                              textStyle: const TextStyle(
                                fontFamily: 'IslandMoments',
                                fontSize: 42,
                                height: 1.1,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              speed: const Duration(milliseconds: 250),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Here is your ticket to the event',
                          style: TextStyle(fontSize: 16, color: whiteText),
                        ),
                        const SizedBox(height: 24),
                        const Center(
                          child: Text(
                            'At the entrance\nplease show this QR Code',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: blackText,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Container(
                            width: 128,
                            height: 128,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png',
                              fit: BoxFit.cover,
                              semanticLabel: 'QR code placeholder',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Center(
                          child: Text(
                            '99581',
                            style: TextStyle(fontSize: 18, color: whiteText),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Note:\n'
                          '- The QR code is non-transferable. Each QR code is generated uniquely and '
                          'assigned to a specific individual only. No other person is permitted to use, '
                          'share, or attempt access using someone else’s QR code.\n\n'
                          '- The QR code may be time-bound or session-based. Expired or invalidated QR '
                          'codes cannot be reused.\n\n'
                          '- The system or issuing authority reserves the right to deactivate or revoke '
                          'QR codes at any time for security or administrative reasons.',
                          style: TextStyle(
                            fontSize: 12,
                            color: whiteText,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
